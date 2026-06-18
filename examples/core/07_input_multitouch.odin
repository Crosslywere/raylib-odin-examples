package core

import "vendor:raylib"
import linalg "core:math/linalg"

MAX_TOUCH_POINTS :: 10

input_multitouch :: proc() {
    // Initialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - input multitouch")
    defer raylib.CloseWindow() // Close window and OpenGL context

    touchPositions : [MAX_TOUCH_POINTS]raylib.Vector2

    raylib.SetTargetFPS(60) // Set our game to run at 60 frames-per-second

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close button or ESC key
        // Update
        // Get the touch point count ( how many fingers are touching the screen )
        tCount := raylib.GetTouchPointCount()
        // Clamp touch points available ( set maximum touch points allowed )
        if tCount > MAX_TOUCH_POINTS { tCount = MAX_TOUCH_POINTS }
        // Get touch points positions
        for i in 0..<tCount { touchPositions[i] = raylib.GetTouchPosition(i) }

        // Draw
        raylib.BeginDrawing()

            raylib.ClearBackground(raylib.RAYWHITE)

            for i in 0..<tCount {
                // Make sure point is not (0, 0) as this means there is no touch for it
                if linalg.length(touchPositions[i]) > 0 {
                    // Draw circle and touch index number
                    raylib.DrawCircleV(touchPositions[i], 34, raylib.ORANGE)
                    raylib.DrawText(raylib.TextFormat("%d", i), i32(touchPositions[i].x) - 10, i32(touchPositions[i].y) - 70, 40, raylib.BLACK)
                }
            }

            raylib.DrawText("touch the screen at multiple locations to get multiple balls", 10, 10, 20, raylib.DARKGRAY)

        raylib.EndDrawing()
    }
    // De-Initialization
}