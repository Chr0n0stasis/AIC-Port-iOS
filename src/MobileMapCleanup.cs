using System;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Profiling;

namespace AIC.iOS
{
    public static class MobileMapCleanup
    {
        private const int LowMemoryDeviceLimitMiB = 3072;
        private const float MemoryWarningCooldownSeconds = 10f;
        private const long LargeAtlasPixels = 4096L * 2048;
        private static bool? lowMemoryDevice;
        private static AsyncOperation pendingCleanup;
        private static bool cleanupRequested;
        private static bool atlasRebuildRequested;
        private static int earliestCleanupFrame;
        private static float lastMemoryWarning = float.NegativeInfinity;
        private static float cleanupStartedAt;
        private static bool tracingMap;
        private static int traceFrames;

        [DllImport("__Internal", EntryPoint = "os_proc_available_memory")]
        private static extern UIntPtr AvailableProcessMemory();

        [StructLayout(LayoutKind.Sequential)]
        private struct MemoryLedger
        {
            public long Footprint;
            public long Graphics;
            public long Media;
            public long Device;
            public long InternalResident;
            public long Compressed;
            public long CriAtom;
            public long CriFs;
        }

        [DllImport("__Internal", EntryPoint = "AICReadMemoryLedger")]
        private static extern int ReadMemoryLedger(out MemoryLedger snapshot);

        public static bool IsLowMemoryDevice
        {
            get
            {
                if (!lowMemoryDevice.HasValue)
                {
                    int memory = SystemInfo.systemMemorySize;
                    lowMemoryDevice = memory > 0 && memory <= LowMemoryDeviceLimitMiB;
                }
                return lowMemoryDevice.Value;
            }
        }

        public static int ClosedMapCacheLimit() => IsLowMemoryDevice ? 0 : 1;

        public static void ApplyLowMemoryDisplay()
        {
            int memory = SystemInfo.systemMemorySize;
            float scale = memory > 0 && memory <= LowMemoryDeviceLimitMiB ? 0.5f :
                memory > 0 && memory <= 4096 ? 0.5f : 1f;
            if (scale >= 1f || Application.platform != RuntimePlatform.IPhonePlayer)
                return;

            int width = Mathf.RoundToInt(Screen.width * scale);
            int height = Mathf.RoundToInt(Screen.height * scale);
            Screen.SetResolution(width, height, true);
            Debug.Log($"[AIC] iOS display resolution: {width}x{height} ({scale:P0})");
        }

        public static int AdjustPixelTextureDimension(int dimension)
        {
            int memory = SystemInfo.systemMemorySize;
            float scale = memory > 0 && memory <= LowMemoryDeviceLimitMiB ? 0.25f :
                memory > 0 && memory <= 4096 ? 0.5f : 1f;
            return scale >= 1f ? dimension : Mathf.Max(1, Mathf.RoundToInt(dimension * scale));
        }

        public static void BeginMapMemoryTrace()
        {
            tracingMap = IsLowMemoryDevice && Application.platform == RuntimePlatform.IPhonePlayer;
            traceFrames = 0;
            TraceMapMemory("before map close");
        }

        public static void TraceMapMemory(string stage)
        {
            if (!tracingMap)
                return;

            WriteMemory(stage);
        }

        public static void TraceEventMemory(string stage)
        {
            if (IsLowMemoryDevice && Application.platform == RuntimePlatform.IPhonePlayer)
                WriteMemory(stage);
        }

        private static void WriteMemory(string stage)
        {
            const long MiB = 1024 * 1024;
            string ledger = ReadMemoryLedger(out MemoryLedger snapshot) != 0
                ? $" footprint={snapshot.Footprint / MiB} MiB graphics={snapshot.Graphics / MiB} MiB" +
                  $" media={snapshot.Media / MiB} MiB device={snapshot.Device / MiB} MiB" +
                  $" internal={snapshot.InternalResident / MiB} MiB compressed={snapshot.Compressed / MiB} MiB" +
                  $" criAtom={snapshot.CriAtom / MiB} MiB criFs={snapshot.CriFs / MiB} MiB"
                : " ledger=unavailable";
            Debug.Log($"[AIC Memory] {stage} frame={Time.frameCount} " +
                $"headroom={AvailableProcessMemory().ToUInt64() / (ulong)MiB} MiB " +
                $"unityUsed={Profiler.GetTotalAllocatedMemoryLong() / MiB} MiB " +
                $"unityReserved={Profiler.GetTotalReservedMemoryLong() / MiB} MiB " +
                $"managed={GC.GetTotalMemory(false) / MiB} MiB " +
                $"textures={Texture.currentTextureMemory / (ulong)MiB} MiB " +
                $"screen={Screen.width}x{Screen.height}" + ledger);
        }

        public static void FinishMapMemoryTrace()
        {
            TraceMapMemory("after map open");
            traceFrames = tracingMap ? 32 : 0;
        }

        // On small devices, allow deferred Destroy calls from the closed map
        // to run at end of frame before scanning for unused assets.
        public static void RequestAfterMapClose()
        {
            cleanupRequested = true;
            earliestCleanupFrame = Time.frameCount + (IsLowMemoryDevice ? 1 : 0);
            atlasRebuildRequested = IsLowMemoryDevice;
        }

        public static bool TakeLargeAtlasRebuild(RenderTexture previousAtlas)
        {
            if (!atlasRebuildRequested || cleanupRequested || pendingCleanup != null)
                return false;

            atlasRebuildRequested = false;
            if (previousAtlas == null || !previousAtlas.IsCreated() ||
                (long)previousAtlas.width * previousAtlas.height < LargeAtlasPixels)
                return false;

            Debug.Log($"[AIC] Rebuilding the {previousAtlas.width}x{previousAtlas.height} map atlas after map close");
            return true;
        }

        internal static void ListenForMemoryWarnings()
        {
            Application.lowMemory -= OnLowMemory;
            Application.lowMemory += OnLowMemory;
        }

        private static void OnLowMemory()
        {
            float now = Time.realtimeSinceStartup;
            if (cleanupRequested || (pendingCleanup != null && !pendingCleanup.isDone) ||
                now - lastMemoryWarning < MemoryWarningCooldownSeconds)
                return;

            lastMemoryWarning = now;
            cleanupRequested = true;
            earliestCleanupFrame = Time.frameCount;
            Debug.Log("[AIC] iOS low-memory warning requested an unused asset sweep");
        }

        public static bool IsPending()
        {
            if (pendingCleanup != null)
            {
                if (!pendingCleanup.isDone)
                    return true;
                pendingCleanup = null;
                Debug.Log($"[AIC] Unused asset sweep completed in {Time.realtimeSinceStartup - cleanupStartedAt:F2}s");
                TraceMapMemory("after unused asset sweep");
            }

            if (!cleanupRequested)
                return false;
            if (Time.frameCount < earliestCleanupFrame)
                return true;

            cleanupRequested = false;
            cleanupStartedAt = Time.realtimeSinceStartup;
            Debug.Log("[AIC] Starting unused asset sweep");
            pendingCleanup = Resources.UnloadUnusedAssets();
            return pendingCleanup != null && !pendingCleanup.isDone;
        }

        // A map can close without an active map loader, for example when
        // returning to the title. Service the same queue from the player loop.
        internal static void Tick()
        {
            IsPending();
            if (traceFrames == 0)
                return;

            if (traceFrames > 28 || traceFrames % 4 == 0)
                TraceMapMemory("after map frame");
            if (--traceFrames == 0)
                tracingMap = false;
        }
    }
}
