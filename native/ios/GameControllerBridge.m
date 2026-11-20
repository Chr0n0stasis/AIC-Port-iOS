#import <GameController/GameController.h>
#include <stdint.h>

typedef struct {
    float leftX, leftY, rightX, rightY, leftTrigger, rightTrigger;
    uint32_t buttons;
} AICGamepadState;

// Button indices in Unity Input System's GamepadState.
enum {
    DpadUp, DpadDown, DpadLeft, DpadRight,
    North, East, South, West,
    LeftStick, RightStick, LeftShoulder, RightShoulder, Start, Select
};

static uint32_t ButtonBit(GCControllerButtonInput *button, unsigned bit)
{
    return button.isPressed ? (1u << bit) : 0;
}

__attribute__((visibility("default")))
void AICPollGameController(AICGamepadState *state)
{
    *state = (AICGamepadState){0};
    @autoreleasepool {
        GCExtendedGamepad *pad = nil;
        for (GCController *controller in GCController.controllers) {
            pad = controller.extendedGamepad;
            if (pad != nil) break;
        }
        if (pad == nil) return;

        state->leftX = pad.leftThumbstick.xAxis.value;
        state->leftY = pad.leftThumbstick.yAxis.value;
        if (state->leftX * state->leftX + state->leftY * state->leftY < 0.02f) {
            state->leftX = pad.dpad.xAxis.value;
            state->leftY = pad.dpad.yAxis.value;
        }
        state->rightX = pad.rightThumbstick.xAxis.value;
        state->rightY = pad.rightThumbstick.yAxis.value;
        state->leftTrigger = pad.leftTrigger.value;
        state->rightTrigger = pad.rightTrigger.value;
        state->buttons =
            ButtonBit(pad.dpad.up, DpadUp) | ButtonBit(pad.dpad.down, DpadDown) |
            ButtonBit(pad.dpad.left, DpadLeft) | ButtonBit(pad.dpad.right, DpadRight) |
            ButtonBit(pad.buttonY, North) | ButtonBit(pad.buttonB, East) |
            ButtonBit(pad.buttonA, South) | ButtonBit(pad.buttonX, West) |
            ButtonBit(pad.leftShoulder, LeftShoulder) | ButtonBit(pad.rightShoulder, RightShoulder);
        if (@available(iOS 12.1, *)) {
            state->buttons |= ButtonBit(pad.leftThumbstickButton, LeftStick) |
                ButtonBit(pad.rightThumbstickButton, RightStick);
        }
        if (@available(iOS 13.0, *)) {
            state->buttons |= ButtonBit(pad.buttonMenu, Start) | ButtonBit(pad.buttonOptions, Select);
        }
    }
}
