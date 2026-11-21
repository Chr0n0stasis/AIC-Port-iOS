using System;
using System.IO;
using UnityEngine;

namespace AIC.iOS
{
    public static class MobileSettings
    {
        private const string DebugFileName = "_debug.txt";
        private const string WormWallImmunityKey = "aic.ios.wormWallImmunity";
        private static bool? wormWallImmune;

        public static bool WormWallImmune
        {
            get
            {
                wormWallImmune ??= PlayerPrefs.GetInt(WormWallImmunityKey, 0) != 0;
                return wormWallImmune.Value;
            }
        }

        internal static void ToggleWormWallImmunity()
        {
            bool enabled = !WormWallImmune;
            PlayerPrefs.SetInt(WormWallImmunityKey, enabled ? 1 : 0);
            wormWallImmune = enabled;
            PlayerPrefs.Save();
        }

        public static string ReadDebugConfig(string bundledText)
        {
            string documents = Application.persistentDataPath;
            if (string.IsNullOrEmpty(documents))
                return bundledText;

            string path = Path.Combine(documents, DebugFileName);
            try
            {
                if (!File.Exists(path))
                {
                    if (string.IsNullOrEmpty(bundledText))
                        return bundledText;
                    Directory.CreateDirectory(documents);
                    SeedDebugConfig(path, bundledText);
                }
                return File.ReadAllText(path);
            }
            catch (Exception error) when (error is IOException || error is UnauthorizedAccessException)
            {
                Debug.LogWarning("[AIC] Using bundled _debug.txt because Documents/_debug.txt could not be opened: " +
                    error.Message);
                return bundledText;
            }
        }

        private static void SeedDebugConfig(string path, string bundledText)
        {
            // Publish the complete file without replacing an edit or an existing file.
            string temporary = path + "." + Guid.NewGuid().ToString("N") + ".tmp";
            try
            {
                File.WriteAllText(temporary, bundledText);
                try
                {
                    File.Move(temporary, path);
                }
                catch (IOException) when (File.Exists(path))
                {
                    // Another writer created the override while the default was being copied.
                }
            }
            finally
            {
                File.Delete(temporary);
            }
        }
    }
}
