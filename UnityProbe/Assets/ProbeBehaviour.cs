using PortProbe;
using UnityEngine;

public sealed class ProbeBehaviour : MonoBehaviour
{
    private string result;

    private void Awake()
    {
#if ENABLE_IL2CPP
        const string Backend = "IL2CPP";
#else
        const string Backend = "Mono";
#endif
        result = $"{Backend}  {Fold.Mix(2166136261u, 0x2au):x8}";
        Debug.Log($"PORT_PROBE {result}");
    }

    private void OnGUI()
    {
        GUI.Label(new Rect(24, 60, 300, 48), result);
    }
}
