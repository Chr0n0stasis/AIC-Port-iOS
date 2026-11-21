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
    public partial class AICTouchOverlay : MonoBehaviour
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
            MobileMapCleanup.ApplyLowMemoryDisplay();

            if (_instance == null)
            {
                var go = new GameObject("[AIC_TouchOverlay]");
                DontDestroyOnLoad(go);
                _instance = go.AddComponent<AICTouchOverlay>();
                MobileMapCleanup.ListenForMemoryWarnings();
            }
        }

        private void LateUpdate() => MobileMapCleanup.Tick();

        private int stickFingerId = -1;
        private Vector2 stickTouchOrigin;
        private Vector2 stickOffset;
        private readonly Dictionary<int, TouchControl> buttonTouches = new Dictionary<int, TouchControl>();

        private GamepadState ReadTouches()
        {
            var state = new GamepadState();
            foreach (var control in controls)
                control.IsHeld = false;

            // Release previous owners before assigning new fingers. Unity need
            // not enumerate simultaneous Began and Ended touches in that order.
            int count = Input.touchCount;
            bool stickStillActive = false;
            for (int i = 0; i < count; i++)
            {
                Touch touch = Input.GetTouch(i);
                if (touch.phase == TouchPhase.Ended || touch.phase == TouchPhase.Canceled)
                {
                    if (buttonTouches.TryGetValue(touch.fingerId, out var control))
                    {
                        if (touch.phase == TouchPhase.Ended && IsVisible(control) &&
                            control.Contains(ToGuiPoint(touch.position)))
                        {
                            if (control.Action == TouchAction.ToggleControls)
                                extraControlsOpen = !extraControlsOpen;
                            else if (control.Action == TouchAction.DebugF7)
                                debugF7Pending = true;
                            else if (control.Action == TouchAction.ToggleWormWallImmunity)
                                MobileSettings.ToggleWormWallImmunity();
                        }
                        buttonTouches.Remove(touch.fingerId);
                    }
                }
                else if (touch.fingerId == stickFingerId)
                {
                    stickStillActive = true;
                }
            }
            if (!stickStillActive)
            {
                stickFingerId = -1;
                stickOffset = Vector2.zero;
            }
            if (count == 0)
                buttonTouches.Clear();

            for (int i = 0; i < count; i++)
            {
                Touch touch = Input.GetTouch(i);
                if (touch.phase == TouchPhase.Ended || touch.phase == TouchPhase.Canceled)
                    continue;

                Vector2 position = ToGuiPoint(touch.position);
                if (touch.phase == TouchPhase.Began && touch.fingerId != stickFingerId &&
                    !buttonTouches.ContainsKey(touch.fingerId))
                {
                    TouchControl control = FindTouchControl(position);
                    if (control != null)
                        buttonTouches.Add(touch.fingerId, control);
                    else if (!hardwareConnected && stickFingerId == -1 &&
                        (position - stickCenter).sqrMagnitude <= stickHitRadius * stickHitRadius)
                    {
                        stickFingerId = touch.fingerId;
                        stickTouchOrigin = position;
                    }
                }

                if (touch.fingerId == stickFingerId)
                    stickOffset = position - stickTouchOrigin;
                else if (buttonTouches.TryGetValue(touch.fingerId, out var control) && IsVisible(control))
                    ApplyTouchControl(control, ref state);
            }

            // AIC's movement actions are four directional controls with their
            // own press thresholds. Keep the existing full deflection past the dead zone.
            float deadZone = 10f * scale;
            if (stickOffset.sqrMagnitude > deadZone * deadZone)
                state.leftStick = new Vector2(stickOffset.x, -stickOffset.y).normalized;
            return state;
        }

        private static void ApplyTouchControl(TouchControl control, ref GamepadState state)
        {
            control.IsHeld = true;
            switch (control.Action)
            {
                case TouchAction.Button:
                    state.buttons |= 1u << (int)control.Button;
                    break;
                case TouchAction.LeftTrigger:
                    state.leftTrigger = 1f;
                    break;
                case TouchAction.RightTrigger:
                    state.rightTrigger = 1f;
                    break;
                case TouchAction.SpellLeft:
                    state.rightStick = Vector2.left;
                    break;
                case TouchAction.SpellUp:
                    state.rightStick = Vector2.up;
                    break;
                case TouchAction.SpellRight:
                    state.rightStick = Vector2.right;
                    break;
                case TouchAction.SpellDown:
                    state.rightStick = Vector2.down;
                    break;
            }
        }

        private void ClearTouchState()
        {
            stickFingerId = -1;
            stickOffset = Vector2.zero;
            buttonTouches.Clear();
            foreach (var control in controls)
                control.IsHeld = false;
        }

        private void OnApplicationFocus(bool focused)
        {
            if (!focused)
            {
                ClearTouchState();
                debugF7Pending = false;
                extraControlsOpen = false;
            }
        }

        private void QueueGamepadState()
        {
            bool connected = PollGameController(out var hardware) != 0;
            if (connected != hardwareConnected)
            {
                ClearTouchState();
                hardwareConnected = connected;
                extraControlsOpen = false;
            }
            Rect safeArea = Screen.safeArea;
            if (layoutWidth != Screen.width || layoutHeight != Screen.height || layoutSafeArea != safeArea)
            {
                ClearTouchState();
                UpdateLayout(safeArea);
            }
            GamepadState touchState = ReadTouches();
            GamepadState state = hardwareConnected ? new GamepadState
            {
                leftStick = new Vector2(hardware.LeftX, hardware.LeftY),
                rightStick = new Vector2(hardware.RightX, hardware.RightY),
                leftTrigger = hardware.LeftTrigger,
                rightTrigger = hardware.RightTrigger,
                buttons = hardware.Buttons,
            } : touchState;

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

    }
}
