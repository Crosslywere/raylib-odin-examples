package core

import "vendor:raylib"

input_mouse_wheel :: proc() {
    // Intialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - input mouse wheel")
    defer raylib.CloseWindow() // Close window and OpenGL context

    boxPositionY : i32 = screenHeight / 2 - 40
    scrollSpeed : i32 = 4 // Scrolling speed in pixels

    raylib.SetTargetFPS(60) // Set our game to run at 60 frames-per-second

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close button or ESC key
        // Update
        boxPositionY -= i32(raylib.GetMouseWheelMove()) * scrollSpeed

        // Drew
        raylib.BeginDrawing()

            raylib.ClearBackground(raylib.RAYWHITE)

            raylib.DrawRectangle(screenWidth / 2 - 40, boxPositionY, 80, 80, raylib.MAROON)

            raylib.DrawText("Use mouse wheel to move cube up and down!", 10, 10, 20, raylib.GRAY)
            raylib.DrawText(raylib.TextFormat("Box position Y: %03i", boxPositionY), 10, 40, 20, raylib.LIGHTGRAY)

        raylib.EndDrawing()
    }
    // De-Initialization
}