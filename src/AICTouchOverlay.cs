using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.LowLevel;
using TouchPhase = UnityEngine.TouchPhase;

namespace AIC.iOS
{
    /// <summary>
    /// AIC On-Screen Touch Controller for iOS
    /// Sends touch controls and Apple's physical gamepads through the game input actions.
    /// </summary>
    public class AICTouchOverlay : MonoBehaviour
    {
        private static AICTouchOverlay _instance;
        private Gamepad bridgePad;
        private PlayerInput player;
        private bool reportedInputError;
        private bool hardwareConnected;
        private float debugF7PolledAt = float.NegativeInfinity;
        private bool debugF7Pending;

        [StructLayout(LayoutKind.Sequential)]
        private struct AppleGamepadState
        {
            public float LeftX, LeftY, RightX, RightY, LeftTrigger, RightTrigger;
            public uint Buttons;
        }

        [DllImport("__Internal", EntryPoint = "AICPollGameController")]
        private static extern int PollGameController(out AppleGamepadState state);

        // Called at the original InputSystem.Update site in XX.IN.run, before
        // KEY.updatePressing consumes button edges and rebuilds the press bits.
        public static void UpdateInputSystem()
        {
            if (_instance != null)
            {
                try
                {
                    _instance.QueueGamepadState();
                }
                catch (Exception error)
                {
                    if (!_instance.reportedInputError)
                    {
                        _instance.reportedInputError = true;
                        Debug.LogException(error);
                    }
                }
            }
            InputSystem.Update();
        }

        // The game calls this only while its event debugger accepts F7.
        public static bool ReadDebugF7(bool keyboardPressed)
        {
            if (_instance == null)
                return keyboardPressed;
            float now = Time.unscaledTime;
            bool touchPressed = _instance.debugF7Pending && now - _instance.debugF7PolledAt < 0.5f;
            _instance.debugF7Pending = false;
            _instance.debugF7PolledAt = now;
            return keyboardPressed || touchPressed;
        }

        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        public static void AutoInit()
        {
            Screen.sleepTimeout = SleepTimeout.NeverSleep;
            Application.targetFrameRate = 60;
            Input.multiTouchEnabled = true;

            if (_instance == null)
            {
                var go = new GameObject("[AIC_TouchOverlay]");
                DontDestroyOnLoad(go);
                _instance = go.AddComponent<AICTouchOverlay>();
            }
        }

        // Layout constants
        private float scale = 1f;
        private int layoutWidth, layoutHeight;
        private Rect leftStickArea;
        private Rect btnJump, btnAtk, btnMagic, btnEvade, btnRun, btnMenu, btnMap;
        private Rect btnDebugF7;

        // Joystick state
        private Vector2 stickOrigin;
        private Vector2 stickCurrent;
        private bool isStickActive;
        private int stickFingerId = -1;

        private readonly Dictionary<int, GamepadButton> buttonTouches = new Dictionary<int, GamepadButton>();
        private uint touchButtons;

        void Awake()
        {
            UpdateLayout();
        }

        void UpdateLayout()
        {
            float w = layoutWidth = Screen.width;
            float h = layoutHeight = Screen.height;
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
            btnDebugF7 = new Rect(btnMap.xMax + 16f * scale, btnMap.y, topBtnSize, topBtnSize);
        }

        private void ReadTouches()
        {
            touchButtons = 0;

            // Process Touch inputs
            int touchCount = Input.touchCount;
            if (touchCount == 0)
            {
                ClearTouchState();
                return;
            }
            bool stickStillActive = false;

            for (int i = 0; i < touchCount; i++)
            {
                Touch t = Input.GetTouch(i);
                if (t.phase == TouchPhase.Ended || t.phase == TouchPhase.Canceled)
                {
                    buttonTouches.Remove(t.fingerId);
                    continue;
                }
                Vector2 screenPos = new Vector2(t.position.x, Screen.height - t.position.y); // Flip Y for GUI

                // Check Left Joystick
                if (t.fingerId == stickFingerId)
                {
                    stickCurrent = screenPos;
                    stickStillActive = true;
                    continue;
                }
                else if (leftStickArea.Contains(screenPos) && !isStickActive && t.phase == TouchPhase.Began)
                {
                    stickFingerId = t.fingerId;
                    stickOrigin = screenPos;
                    stickCurrent = screenPos;
                    isStickActive = true;
                    stickStillActive = true;
                    continue;
                }

                if (t.phase == TouchPhase.Began)
                {
                    buttonTouches.Remove(t.fingerId);
                    var button = GetTouchButton(screenPos);
                    if (button.HasValue)
                        buttonTouches[t.fingerId] = button.Value;
                }

                if (buttonTouches.TryGetValue(t.fingerId, out var heldButton))
                    touchButtons |= 1u << (int)heldButton;
            }

            if (!stickStillActive)
            {
                isStickActive = false;
                stickFingerId = -1;
            }
        }

        private GamepadButton? GetTouchButton(Vector2 position)
        {
            if (btnJump.Contains(position)) return GamepadButton.South;
            if (btnAtk.Contains(position)) return GamepadButton.West;
            if (btnMagic.Contains(position)) return GamepadButton.East;
            if (btnEvade.Contains(position)) return GamepadButton.North;
            if (btnRun.Contains(position)) return GamepadButton.LeftStick;
            if (btnMenu.Contains(position)) return GamepadButton.Start;
            if (btnMap.Contains(position)) return GamepadButton.LeftShoulder;
            return null;
        }

        private void ClearTouchState()
        {
            isStickActive = false;
            stickFingerId = -1;
            buttonTouches.Clear();
            touchButtons = 0;
        }

        private void OnApplicationFocus(bool focused)
        {
            if (!focused)
            {
                ClearTouchState();
                debugF7Pending = false;
            }
        }

        private void QueueGamepadState()
        {
            bool connected = PollGameController(out var hardware) != 0;
            if (connected != hardwareConnected)
            {
                ClearTouchState();
                hardwareConnected = connected;
            }
            if (layoutWidth != Screen.width || layoutHeight != Screen.height)
            {
                ClearTouchState();
                UpdateLayout();
            }
            if (!hardwareConnected)
                ReadTouches();

            var state = new GamepadState
            {
                leftStick = new Vector2(hardware.LeftX, hardware.LeftY),
                rightStick = new Vector2(hardware.RightX, hardware.RightY),
                leftTrigger = hardware.LeftTrigger,
                rightTrigger = hardware.RightTrigger,
                buttons = hardwareConnected ? hardware.Buttons : touchButtons,
            };

            if (isStickActive)
            {
                Vector2 delta = stickCurrent - stickOrigin;
                if (delta.magnitude > 25f * scale)
                    state.leftStick = new Vector2(delta.x, -delta.y).normalized;
            }

            bool active = state.buttons != 0 || state.leftStick.sqrMagnitude > 0.02f ||
                state.rightStick.sqrMagnitude > 0.02f || state.leftTrigger > 0.2f || state.rightTrigger > 0.2f;
            if (active)
            {
                if (bridgePad == null)
                    bridgePad = InputSystem.AddDevice<Gamepad>("AIC Mobile Gamepad");
                if (player == null)
                    player = FindObjectOfType<PlayerInput>();
                PairBridgePad();
            }

            if (bridgePad != null)
                InputSystem.QueueStateEvent(bridgePad, state);
        }

        private void PairBridgePad()
        {
            if (player == null)
                return;
            // Touches can also produce pointer activity. Keep the player's action
            // scheme paired to the bridge while the mobile controls are in use.
            if (!player.neverAutoSwitchControlSchemes)
                player.neverAutoSwitchControlSchemes = true;
            foreach (var device in player.devices)
            {
                if (device == bridgePad)
                    return;
            }
            player.SwitchCurrentControlScheme("Gamepad", bridgePad);
        }

        private bool TouchButtonPressed(GamepadButton button) => (touchButtons & (1u << (int)button)) != 0;

        void OnGUI()
        {
            if (Time.unscaledTime - debugF7PolledAt < 0.5f && GUI.Button(btnDebugF7, "F7"))
                debugF7Pending = true;

            if (hardwareConnected)
                return;

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
            GUI.color = TouchButtonPressed(GamepadButton.South) ? new Color(1f, 0.9f, 0.3f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnJump, "JUMP\n(A)");

            GUI.color = TouchButtonPressed(GamepadButton.West) ? new Color(1f, 0.3f, 0.3f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnAtk, "ATK\n(X)");

            GUI.color = TouchButtonPressed(GamepadButton.East) ? new Color(0.8f, 0.4f, 1f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnMagic, "MAGIC\n(B)");

            GUI.color = TouchButtonPressed(GamepadButton.North) ? new Color(0.3f, 1f, 0.5f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnEvade, "DASH\n(Y)");

            GUI.color = TouchButtonPressed(GamepadButton.LeftStick) ? new Color(1f, 0.6f, 0.2f, 0.8f) : new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnRun, "RUN");

            // Utility buttons
            GUI.color = new Color(1f, 1f, 1f, 0.45f);
            GUI.Box(btnMenu, "MENU");
            GUI.Box(btnMap, "MAP");

            GUI.color = prevColor;
        }
    }
}
