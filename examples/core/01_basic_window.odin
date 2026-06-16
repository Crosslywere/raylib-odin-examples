package core

import "vendor:raylib"

basic_window :: proc() {
    // Initialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window")
    defer raylib.CloseWindow() // Close window and OpenGL Context

    raylib.SetTargetFPS(60) // Set our game to run at 60 frames-per-second

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close button or ESC key
        // Update
        // TODO: Update your variables here

        // Draw
        raylib.BeginDrawing()

            raylib.ClearBackground(raylib.RAYWHITE)

            raylib.DrawText("Congrats! You created your first window!", 190, 200, 20, raylib.LIGHTGRAY)

        raylib.EndDrawing()
    }
    // De-Initialization
}