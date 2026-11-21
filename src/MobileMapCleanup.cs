using UnityEngine;

namespace AIC.iOS
{
    public static class MobileMapCleanup
    {
        private const int LowMemoryDeviceLimitMiB = 3072;
        private const float MemoryWarningCooldownSeconds = 10f;
        private static bool? lowMemoryDevice;
        private static AsyncOperation pendingCleanup;
        private static bool cleanupRequested;
        private static int earliestCleanupFrame;
        private static float lastMemoryWarning = float.NegativeInfinity;
        private static float cleanupStartedAt;

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

        // On small devices, allow deferred Destroy calls from the closed map
        // to run at end of frame before scanning for unused assets.
        public static void RequestAfterMapClose()
        {
            cleanupRequested = true;
            earliestCleanupFrame = Time.frameCount + (IsLowMemoryDevice ? 1 : 0);
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
        internal static void Tick() => IsPending();
    }
}
