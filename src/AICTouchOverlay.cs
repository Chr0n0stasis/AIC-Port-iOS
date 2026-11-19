using System;
using UnityEngine;

namespace AIC.iOS
{
    /// <summary>
    /// AIC On-Screen Touch Controller for iOS
    /// Automatically injects virtual thumbstick and action buttons into XX.IN / XX.KEY.
    /// </summary>
    public class AICTouchOverlay : MonoBehaviour
    {
        private static AICTouchOverlay _instance;

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        public static void AutoInit()
        {
            Screen.sleepTimeout = SleepTimeout.NeverSleep;
            Application.targetFrameRate = 60;

            if (_instance == null)
            {
                var go = new GameObject("[AIC_TouchOverlay]");
                DontDestroyOnLoad(go);
                _instance = go.AddComponent<AICTouchOverlay>();
            }
        }

        // Layout constants
        private float scale = 1f;
        private Rect leftStickArea;
        private Rect btnJump, btnAtk, btnMagic, btnEvade, btnRun, btnMenu, btnMap;

        // Joystick state
        private Vector2 stickOrigin;
        private Vector2 stickCurrent;
        private bool isStickActive;
        private int stickFingerId = -1;

        // Button state
        private bool pressedJump, pressedAtk, pressedMagic, pressedEvade, pressedRun, pressedMenu, pressedMap;

        void Awake()
        {
            UpdateLayout();
        }

        void UpdateLayout()
        {
            float w = Screen.width;
            float h = Screen.height;
            // Base scale on screen height (assuming reference height 1080)
            scale = Mathf.Max(1.0f, h / 1080f);

            float padSize = 260f * scale;
            leftStickArea = new Rect(40f * scale, h - padSize - 40f * scale, padSize, padSize);

            float btnRadius = 85f * scale;
            float rightMargin = w - 40f * scale;
            float bottomMargin = h - 40f * scale;

            // Action cluster layout (Diamond layout on right)
            btnJump = new Rect(rightMargin - btnRadius * 2.2f, bottomMargin - btnRadius * 1.5f, btnRadius, btnRadius);
            btnAtk = new Rect(rightMargin - btnRadius * 3.5f, bottomMargin - btnRadius * 2.5f, btnRadius, btnRadius);
            btnMagic = new Rect(rightMargin - btnRadius * 2.2f, bottomMargin - btnRadius * 3.8f, btnRadius, btnRadius);
            btnEvade = new Rect(rightMargin - btnRadius * 0.9f, bottomMargin - btnRadius * 2.5f, btnRadius, btnRadius);
            btnRun = new Rect(rightMargin - btnRadius * 0.9f, bottomMargin - btnRadius * 4.0f, btnRadius * 0.9f, btnRadius * 0.9f);

            // Top utility buttons
            float topBtnSize = 70f * scale;
            btnMenu = new Rect(w - topBtnSize - 40f * scale, 30f * scale, topBtnSize, topBtnSize);
            btnMap = new Rect(40f * scale, 30f * scale, topBtnSize, topBtnSize);
        }

        void Update()
        {
            // Reset button states
            pressedJump = false;
            pressedAtk = false;
            pressedMagic = false;
            pressedEvade = false;
            pressedRun = false;
            pressedMenu = false;
            pressedMap = false;

            // Process Touch inputs
            int touchCount = Input.touchCount;
            bool stickStillActive = false;

            for (int i = 0; i < touchCount; i++)
            {
                Touch t = Input.GetTouch(i);
                Vector2 screenPos = new Vector2(t.position.x, Screen.height - t.position.y); // Flip Y for GUI

                // Check Left Joystick
                if (t.fingerId == stickFingerId)
                {
                    if (t.phase == TouchPhase.Moved || t.phase == TouchPhase.Stationary)
                    {
                        stickCurrent = screenPos;
                        stickStillActive = true;
                    }
                    else if (t.phase == TouchPhase.Ended || t.phase == TouchPhase.Canceled)
                    {
                        stickFingerId = -1;
                        isStickActive = false;
                    }
                }
                else if (leftStickArea.Contains(screenPos) && !isStickActive && t.phase == TouchPhase.Began)
                {
                    stickFingerId = t.fingerId;
                    stickOrigin = screenPos;
                    stickCurrent = screenPos;
                    isStickActive = true;
                    stickStillActive = true;
                }

                // Check Action Buttons
                if (btnJump.Contains(screenPos)) pressedJump = true;
                if (btnAtk.Contains(screenPos)) pressedAtk = true;
                if (btnMagic.Contains(screenPos)) pressedMagic = true;
                if (btnEvade.Contains(screenPos)) pressedEvade = true;
                if (btnRun.Contains(screenPos)) pressedRun = true;
                if (btnMenu.Contains(screenPos)) pressedMenu = true;
                if (btnMap.Contains(screenPos)) pressedMap = true;
            }

            if (!stickStillActive)
            {
                isStickActive = false;
                stickFingerId = -1;
            }

            // Feed into XX.IN / XX.KEY
            ApplyInputToGame();
        }

        private void ApplyInputToGame()
        {
            try
            {
                if (XX.IN.KA == null) return;

                // 1. Directional Vector from Stick
                if (isStickActive)
                {
                    Vector2 delta = stickCurrent - stickOrigin;
                    float threshold = 25f * scale;
                    if (delta.magnitude > threshold)
                    {
                        Vector2 dir = delta.normalized;
                        if (dir.x > 0.35f)
                        {
                            XX.IN.KA.mvRA = Mathf.Max(XX.IN.KA.mvRA, 1f);
                            XX.IN.pd_bits |= XX.IN.PB.R;
                        }
                        if (dir.x < -0.35f)
                        {
                            XX.IN.KA.mvLA = Mathf.Max(XX.IN.KA.mvLA, 1f);
                            XX.IN.pd_bits |= XX.IN.PB.L;
                        }
                        if (dir.y < -0.35f) // Up on screen
                        {
                            XX.IN.KA.mvTA = Mathf.Max(XX.IN.KA.mvTA, 1f);
                            XX.IN.pd_bits |= XX.IN.PB.T;
                        }
                        if (dir.y > 0.35f) // Down on screen
                        {
                            XX.IN.KA.mvBA = Mathf.Max(XX.IN.KA.mvBA, 1f);
                            XX.IN.pd_bits |= XX.IN.PB.B;
                        }
                    }
                }

                // 2. Action Buttons
                if (pressedJump) XX.IN.KA.mvJUMP = Mathf.Max(XX.IN.KA.mvJUMP, 1f);
                if (pressedAtk) XX.IN.KA.mvZ = Mathf.Max(XX.IN.KA.mvZ, 1f);
                if (pressedMagic) XX.IN.KA.mvX = Mathf.Max(XX.IN.KA.mvX, 1f);
                if (pressedEvade) XX.IN.KA.mvC = Mathf.Max(XX.IN.KA.mvC, 1f);
                if (pressedRun) XX.IN.KA.mvRUN = Mathf.Max(XX.IN.KA.mvRUN, 1f);
                if (pressedMenu) XX.IN.KA.mvMENU = Mathf.Max(XX.IN.KA.mvMENU, 1f);
                if (pressedMap) XX.IN.KA.mvCHECK = Mathf.Max(XX.IN.KA.mvCHECK, 1f);
            }
            catch
            {
                // Safety guard during scene transition
            }
        }

        void OnGUI()
        {
            // Semi-transparent style
            var prevColor = GUI.color;
            GUI.color = new Color(1f, 1f, 1f, 0.45f);

            // Draw Joystick Base & Knob
            GUI.Box(leftStickArea, "PAD");
            if (isStickActive)
            {
                float knobRadius = 60f * scale;
                Rect knobRect = new Rect(stickCurrent.x - knobRadius / 2f, stickCurrent.y - knobRadius / 2f, knobRadius, knobRadius);
                GUI.color = new Color(0.3f, 0.8f, 1f, 0.75f);
                GUI.Box(knobRect, "");
            }

            // Draw Action Buttons
            GUI.color = pressedJump ? new Color(1f, 0.9f, 0.3f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnJump, "JUMP\n(A)");

            GUI.color = pressedAtk ? new Color(1f, 0.3f, 0.3f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnAtk, "ATK\n(X)");

            GUI.color = pressedMagic ? new Color(0.8f, 0.4f, 1f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnMagic, "MAGIC\n(Y)");

            GUI.color = pressedEvade ? new Color(0.3f, 1f, 0.5f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnEvade, "DASH\n(B)");

            GUI.color = pressedRun ? new Color(1f, 0.6f, 0.2f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnRun, "RUN");

            // Utility buttons
            GUI.color = new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnMenu, "MENU");
            GUI.Box(btnMap, "MAP");

            GUI.color = prevColor;
        }
    }
}
