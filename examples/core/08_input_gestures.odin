package core

import "vendor:raylib"
import "core:strings"

MAX_GESTURE_STRINGS :: 20

input_gestures :: proc() {
    // Initialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - input gestures")
    defer raylib.CloseWindow() // Closw window and OpenGL context

    touchPosition : raylib.Vector2 = {}
    touchArea : raylib.Rectangle = { 220, 10, f32(screenWidth) - 230, f32(screenHeight) - 20}

    gesturesCount := 0
    gestureStrings : [MAX_GESTURE_STRINGS][32]byte = {}

    currentGesture : raylib.Gestures
    lastGesture : raylib.Gestures

    //raylib.SetGesturesEnabled({.TAP}) // Enable only some gestures to be detected

    raylib.SetTargetFPS(60)

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close button or ESC key
        // Update
        lastGesture = currentGesture
        currentGesture = raylib.GetGestureDetected()
        touchPosition = raylib.GetTouchPosition(0)

        if raylib.CheckCollisionPointRec(touchPosition, touchArea) && currentGesture != {} {
            if currentGesture != lastGesture {
                // Store gesture string
                switch currentGesture {
                case {.TAP}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE TAP")
                case {.DOUBLETAP}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE DOUBLE TAP")
                case {.HOLD}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE HOLD")
                case {.DRAG}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE DRAG")
                case {.SWIPE_RIGHT}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE SWIPE RIGHT")
                case {.SWIPE_LEFT}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE SWIPE LEFT")
                case {.SWIPE_UP}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE SWIPE UP")
                case {.SWIPE_DOWN}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE SWIPE DOWN")
                case {.PINCH_IN}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE PINCH IN")
                case {.PINCH_OUT}: raylib.TextCopy(cast([^]byte)&gestureStrings[gesturesCount][0], "GESTURE PINCH OUT")
                }

                gesturesCount += 1

                // Reset gestures strings
                if gesturesCount >= MAX_GESTURE_STRINGS {
                    for i in 0..<MAX_GESTURE_STRINGS { raylib.TextCopy(&gestureStrings[i][0], nil) }

                    gesturesCount = 0
                }
            }
        }

        // Drawing
        raylib.BeginDrawing()

            raylib.ClearBackground(raylib.RAYWHITE)

            raylib.DrawRectangleRec(touchArea, raylib.GRAY)
            raylib.DrawRectangle(225, 15, screenWidth - 240, screenHeight - 30, raylib.RAYWHITE)

            raylib.DrawText("GESTURE TEST AREA", screenWidth - 270, screenHeight - 40, 20, raylib.Fade(raylib.GRAY, 0.5))

            for i in 0..<gesturesCount {
                if i % 2 == 0 { raylib.DrawRectangle(10, 30 + 20 * i32(i), 200, 20, raylib.Fade(raylib.LIGHTGRAY, 0.5)) }
                else { raylib.DrawRectangle(10, 30 + 20 * i32(i), 200, 20, raylib.Fade(raylib.LIGHTGRAY, 0.3)) }

                if i < gesturesCount - 1 { raylib.DrawText(cast(cstring)&gestureStrings[i][0], 35, 36 + 20 * i32(i), 10, raylib.GRAY) }
                else { raylib.DrawText(cast(cstring)&gestureStrings[i][0], 35, 36 + 20 * i32(i), 10, raylib.MAROON) }
            }

            raylib.DrawRectangleLines(10, 29, 200, screenHeight - 50, raylib.GRAY)
            raylib.DrawText("DETECTED GESTURES", 50, 15, 10, raylib.GRAY)

            if currentGesture != {} { raylib.DrawCircleV(touchPosition, 30, raylib.MAROON) }

        raylib.EndDrawing()
    }
    // De-Initialization
}