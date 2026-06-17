package core

import "vendor:raylib"

input_mouse :: proc() {
    // Initialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - input mouse")
    defer raylib.CloseWindow() // Close window and OpenGL context

    ballPosition : raylib.Vector2 = { -100, -100 }
    ballColor : raylib.Color = raylib.DARKBLUE

    raylib.SetTargetFPS(60) // Set our game to run at 60 frames-per-second

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close button or ESC key
        // Update
        if raylib.IsKeyPressed(.H) {
            if raylib.IsCursorHidden() { raylib.ShowCursor() }
            else { raylib.HideCursor() }
        }

        ballPosition = raylib.GetMousePosition()

        switch {
        case raylib.IsMouseButtonPressed(.LEFT): ballColor = raylib.MAROON
        case raylib.IsMouseButtonPressed(.MIDDLE): ballColor = raylib.LIME
        case raylib.IsMouseButtonPressed(.RIGHT): ballColor = raylib.DARKBLUE
        case raylib.IsMouseButtonPressed(.SIDE): ballColor = raylib.PURPLE
        case raylib.IsMouseButtonPressed(.EXTRA): ballColor = raylib.YELLOW
        case raylib.IsMouseButtonPressed(.FORWARD): ballColor = raylib.ORANGE
        case raylib.IsMouseButtonPressed(.BACK): ballColor = raylib.BEIGE
        }

        // Draw
        raylib.BeginDrawing()

            raylib.ClearBackground(raylib.RAYWHITE)

            raylib.DrawCircleV(ballPosition, 40, ballColor)

            raylib.DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, raylib.DARKGRAY)
            raylib.DrawText("Press 'H' to toggle cursor visibility", 10, 30, 20, raylib.DARKGRAY)

            if raylib.IsCursorHidden() { raylib.DrawText("CURSOR HIDDEN", 20, 60, 20, raylib.RED) }
            else { raylib.DrawText("CURSOR VISIBLE", 20, 60, 20, raylib.LIME) }

        raylib.EndDrawing()
    }
    // De-Initialization
}