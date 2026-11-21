using UnityEngine;

namespace AIC.iOS
{
    public static class MobileMapCleanup
    {
        private static AsyncOperation pendingCleanup;

        // The game already requests this sweep when closing its current map.
        public static AsyncOperation Begin()
        {
            pendingCleanup = Resources.UnloadUnusedAssets();
            return pendingCleanup;
        }

        public static bool IsPending()
        {
            if (pendingCleanup != null && !pendingCleanup.isDone)
                return true;

            pendingCleanup = null;
            return false;
        }
    }
}
