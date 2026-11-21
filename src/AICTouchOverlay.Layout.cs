using UnityEngine;
using UnityEngine.InputSystem.LowLevel;

namespace AIC.iOS
{
    public partial class AICTouchOverlay
    {
        private enum TouchAction
        {
            Button, LeftTrigger, RightTrigger, SpellLeft, SpellUp, SpellRight, SpellDown,
            ToggleControls, DebugF7, ToggleWormWallImmunity,
        }

        private sealed class TouchControl
        {
            internal readonly string Label;
            internal readonly TouchAction Action;
            internal readonly GamepadButton Button;
            internal readonly Color Accent;
            internal readonly bool Round;
            internal readonly string MenuHint;
            internal Rect Bounds;
            internal bool IsHeld;
            internal bool IsExtra;

            internal TouchControl(string label, GamepadButton button)
                : this(label, TouchAction.Button) => Button = button;

            internal TouchControl(string label, GamepadButton button, Color accent, string menuHint = null)
                : this(label, button)
            {
                Accent = accent;
                Round = true;
                MenuHint = menuHint;
            }

            internal TouchControl(string label, TouchAction action)
            {
                Label = label;
                Action = action;
                Accent = Brass;
            }

            internal bool Contains(Vector2 position)
            {
                if (!Round)
                    return Bounds.Contains(position);
                float radius = Bounds.width * 0.5f;
                return (position - Bounds.center).sqrMagnitude <= radius * radius;
            }
        }

        private static readonly Color Brass = new Color32(222, 192, 139, 255);
        private static readonly Color Glass = new Color32(26, 23, 35, 168);
        private static readonly Color Ink = new Color32(255, 247, 229, 255);

        // Default bindings from AIC's serialized InputActionAsset.
        private readonly TouchControl attack = new TouchControl("ATK", GamepadButton.West, new Color32(237, 153, 143, 255));
        private readonly TouchControl magic = new TouchControl("MAGIC", GamepadButton.East, new Color32(196, 170, 241, 255), "BACK");
        private readonly TouchControl dodge = new TouchControl("DODGE", GamepadButton.RightShoulder, Brass);
        private readonly TouchControl jump = new TouchControl("JUMP", GamepadButton.South, new Color32(161, 221, 196, 255), "OK");
        private readonly TouchControl run = new TouchControl("RUN", GamepadButton.LeftStick);
        private readonly TouchControl target = new TouchControl("TARGET", GamepadButton.North);
        private readonly TouchControl map = new TouchControl("MAP", GamepadButton.LeftShoulder);
        private readonly TouchControl item = new TouchControl("ITEM", GamepadButton.DpadUp);
        private readonly TouchControl menu = new TouchControl("MENU", GamepadButton.Start);
        private readonly TouchControl more = new TouchControl("···", TouchAction.ToggleControls);
        private readonly TouchControl debug = new TouchControl("F7", TouchAction.DebugF7);
        private readonly TouchControl wormWall = new TouchControl("WORM GUARD", TouchAction.ToggleWormWallImmunity);
        private readonly TouchControl[] extraControls =
        {
            new TouchControl("L TAB", GamepadButton.LeftShoulder),
            new TouchControl("R TAB", GamepadButton.RightShoulder),
            new TouchControl("SHIFT", TouchAction.LeftTrigger),
            new TouchControl("SORT", TouchAction.RightTrigger),
            new TouchControl("SPELL", GamepadButton.RightStick),
            new TouchControl("SPELL L", TouchAction.SpellLeft),
            new TouchControl("SPELL U", TouchAction.SpellUp),
            new TouchControl("SPELL R", TouchAction.SpellRight),
            new TouchControl("SPELL D", TouchAction.SpellDown),
        };
        private static readonly Vector2[] StickDirections = { Vector2.up, Vector2.right, Vector2.down, Vector2.left };

        private TouchControl[] controls;
        private int firstExtraControl;
        private bool extraControlsOpen;
        private int layoutWidth, layoutHeight;
        private Rect layoutSafeArea;
        private float scale;
        private Vector2 stickCenter;
        private float stickHitRadius;
        private Texture2D disc;
        private Texture2D ring;
        private GUIStyle controlLabel;

        private void Awake()
        {
            var primary = new[] { attack, magic, dodge, jump, run, target, map, item, menu, more, debug, wormWall };
            firstExtraControl = primary.Length;
            controls = new TouchControl[primary.Length + extraControls.Length];
            primary.CopyTo(controls, 0);
            extraControls.CopyTo(controls, firstExtraControl);
            foreach (var control in extraControls)
                control.IsExtra = true;
            UpdateLayout(Screen.safeArea);
        }

        private void UpdateLayout(Rect safeArea)
        {
            layoutWidth = Screen.width;
            layoutHeight = Screen.height;
            layoutSafeArea = safeArea;
            if (safeArea.width <= 0f || safeArea.height <= 0f)
                safeArea = new Rect(0f, 0f, layoutWidth, layoutHeight);

            // The safe area is in bottom-left coordinates. Anchor the controls
            // in GUI coordinates so both landscape orientations clear the notch.
            scale = Mathf.Min(safeArea.width / 650f, safeArea.height / 360f);
            float dpi = Screen.dpi;
            if (dpi > 0f)
                scale = Mathf.Min(scale, dpi / 140f);
            float left = safeArea.xMin;
            float right = safeArea.xMax;
            float top = layoutHeight - safeArea.yMax;
            float bottom = layoutHeight - safeArea.yMin;

            stickCenter = new Vector2(left + 94f * scale, bottom - 96f * scale);
            stickHitRadius = 79f * scale;
            float x = right - 105f * scale;
            float y = bottom - 94f * scale;
            Place(attack, x, y, -54f, 0f, 59f, 59f);
            Place(magic, x, y, 0f, -55f, 59f, 59f);
            Place(dodge, x, y, 54f, 0f, 59f, 59f);
            Place(jump, x, y, 0f, 53f, 62f, 62f);
            Place(run, x, y, -68f, -62f, 58f, 46f);
            Place(target, x, y, 68f, -62f, 62f, 46f);
            Place(item, x, y, 63f, 54f, 58f, 46f);

            Place(map, left, top, 50f, 35f, 64f, 46f);
            Place(debug, left, top, 113f, 35f, 46f, 46f);
            Place(menu, right, top, -50f, 35f, 64f, 46f);
            Place(more, right, top, -113f, 35f, 46f, 46f);

            float center = safeArea.center.x;
            for (int i = 0; i < 4; i++)
                Place(extraControls[i], center, top, (i - 1.5f) * 65f, 87f, 59f, 46f);
            for (int i = 4; i < extraControls.Length; i++)
                Place(extraControls[i], center, top, (i - 6f) * 70f, 139f, 64f, 46f);
            Place(wormWall, center, top, 0f, 191f, 142f, 46f);
        }

        private void Place(TouchControl control, float anchorX, float anchorY,
            float offsetX, float offsetY, float width, float height)
        {
            control.Bounds = CenteredRect(
                new Vector2(anchorX + offsetX * scale, anchorY + offsetY * scale), width * scale, height * scale);
        }

        private static Rect CenteredRect(Vector2 center, float width, float height) =>
            new Rect(center.x - width * 0.5f, center.y - height * 0.5f, width, height);

        private Vector2 ToGuiPoint(Vector2 point) => new Vector2(point.x, layoutHeight - point.y);

        private bool IsVisible(TouchControl control)
        {
            if (control == debug)
                return Time.unscaledTime - debugF7PolledAt < 0.5f;
            if (control == more)
                return true;
            if (control == wormWall)
                return extraControlsOpen;
            return !hardwareConnected && (!control.IsExtra || extraControlsOpen);
        }

        private TouchControl FindTouchControl(Vector2 position)
        {
            int count = extraControlsOpen ? controls.Length : firstExtraControl;
            for (int i = 0; i < count; i++)
            {
                TouchControl control = controls[i];
                if (control.Contains(position) && IsVisible(control))
                    return control;
            }
            return null;
        }

        private void OnGUI()
        {
            if (Event.current.type != EventType.Repaint)
                return;

            if (controlLabel == null)
            {
                controlLabel = new GUIStyle(GUI.skin.label)
                {
                    alignment = TextAnchor.MiddleCenter,
                    fontStyle = FontStyle.Bold,
                    padding = new RectOffset(),
                };
                controlLabel.normal.textColor = Color.white;
                disc = MakeCircle(false);
                ring = MakeCircle(true);
            }

            Color previous = GUI.color;
            if (!hardwareConnected)
                DrawStick();
            foreach (var control in controls)
            {
                if (IsVisible(control))
                    DrawControl(control);
            }
            GUI.color = previous;
        }

        private void DrawStick()
        {
            bool active = stickFingerId != -1;
            DrawCircle(stickCenter, 128f, disc, Glass);
            DrawCircle(stickCenter, 128f, ring, Alpha(Brass, active ? 0.7f : 0.42f));
            DrawCircle(stickCenter, 102f, ring, Alpha(Brass, 0.19f));
            foreach (var direction in StickDirections)
                DrawCircle(stickCenter + direction * (55f * scale), 4f, disc, Alpha(Brass, 0.66f));

            Vector2 knob = stickCenter + Vector2.ClampMagnitude(stickOffset, 37f * scale);
            DrawCircle(knob, 48f, disc, new Color32(63, 53, 71, 227));
            DrawCircle(knob, 48f, ring, Alpha(Brass, active ? 1f : 0.6f));
            DrawCircle(knob, 32f, ring, Alpha(Brass, 0.25f));
            DrawCircle(knob, 6f, disc, Alpha(Brass, active ? 1f : 0.7f));
        }

        private void DrawControl(TouchControl control)
        {
            bool wormWallEnabled = control == wormWall && MobileSettings.WormWallImmune;
            bool pressed = control.IsHeld || (control == more && extraControlsOpen) || wormWallEnabled;
            Rect rect = control.Bounds;
            Color surface = pressed ? Alpha(control.Accent, 0.68f) : Glass;
            if (control.Round)
            {
                Blit(rect, disc, surface);
                Blit(rect, ring, Alpha(control.Accent, pressed ? 1f : 0.65f));
                DrawCircle(new Vector2(rect.center.x, rect.yMin + 11f * scale),
                    4f, disc, Alpha(control.Accent, pressed ? 1f : 0.8f));
            }
            else
            {
                BlitPill(rect, surface);
                Color accent = Alpha(control.Accent, pressed ? 0.9f : 0.55f);
                Blit(CenteredRect(new Vector2(rect.center.x, rect.yMax - 7f * scale),
                    13f * scale, 1.5f * scale), Texture2D.whiteTexture, accent);
            }

            GUI.color = pressed ? new Color32(28, 21, 31, 255) : Ink;
            controlLabel.fontSize = Mathf.Max(10, Mathf.RoundToInt((control.Round ? 12f : 11f) * scale));
            string label = control == wormWall
                ? (wormWallEnabled ? "WORM GUARD ON" : "WORM GUARD OFF")
                : control.Label;
            GUI.Label(rect, label, controlLabel);
            if (control.MenuHint != null)
            {
                GUI.color = pressed ? new Color32(28, 21, 31, 255) : Alpha(Ink, 0.68f);
                controlLabel.fontSize = Mathf.Max(8, Mathf.RoundToInt(8f * scale));
                GUI.Label(new Rect(rect.x, rect.y + 14f * scale, rect.width, rect.height),
                    control.MenuHint, controlLabel);
            }
        }

        private void DrawCircle(Vector2 center, float diameter, Texture2D texture, Color color)
        {
            float size = diameter * scale;
            Blit(CenteredRect(center, size, size), texture, color);
        }

        private void BlitPill(Rect rect, Color color)
        {
            float diameter = Mathf.Min(rect.height, rect.width);
            float radius = diameter * 0.5f;
            GUI.color = color;
            GUI.DrawTextureWithTexCoords(new Rect(rect.xMin, rect.yMin, radius, diameter),
                disc, new Rect(0f, 0f, 0.5f, 1f));
            GUI.DrawTextureWithTexCoords(new Rect(rect.xMax - radius, rect.yMin, radius, diameter),
                disc, new Rect(0.5f, 0f, 0.5f, 1f));
            float width = rect.width - diameter;
            if (width > 0f)
                Blit(new Rect(rect.xMin + radius, rect.yMin, width, rect.height), Texture2D.whiteTexture, color);
        }

        private static void Blit(Rect rect, Texture2D texture, Color color)
        {
            GUI.color = color;
            GUI.DrawTexture(rect, texture);
        }

        private static Color Alpha(Color color, float alpha)
        {
            color.a = alpha;
            return color;
        }

        private static Texture2D MakeCircle(bool outline)
        {
            const int size = 128;
            var texture = new Texture2D(size, size, TextureFormat.RGBA32, false, true)
            {
                filterMode = FilterMode.Bilinear,
                wrapMode = TextureWrapMode.Clamp,
                hideFlags = HideFlags.HideAndDontSave,
            };
            var pixels = new Color32[size * size];
            for (int y = 0; y < size; y++)
            {
                for (int x = 0; x < size; x++)
                {
                    float radius = new Vector2(x + 0.5f - size * 0.5f, y + 0.5f - size * 0.5f).magnitude;
                    float opacity = Mathf.Clamp01(size * 0.5f - radius - 0.25f);
                    if (outline)
                        opacity *= Mathf.Clamp01(radius - size * 0.47f);
                    pixels[y * size + x] = new Color32(255, 255, 255, (byte)(opacity * 255f));
                }
            }
            texture.SetPixels32(pixels);
            texture.Apply(false, true);
            return texture;
        }

        private void OnDestroy()
        {
            if (disc != null)
                Destroy(disc);
            if (ring != null)
                Destroy(ring);
        }
    }
}
