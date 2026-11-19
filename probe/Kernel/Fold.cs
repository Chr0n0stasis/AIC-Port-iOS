namespace PortProbe
{
    public static class Fold
    {
        public static uint Mix(uint seed, uint value)
        {
            return unchecked((seed ^ value) * 16777619u);
        }
    }
}
