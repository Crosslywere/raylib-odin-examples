package core

import "vendor:raylib"

input_keys :: proc() {
    // Initialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - input keys")
    defer raylib.CloseWindow() // Close window and OpenGL context

    ballPosition : raylib.Vector2 = { f32(screenWidth) / 2, f32(screenHeight) / 2 }

    raylib.SetTargetFPS(60) // Set our game to run at 60 frames-per-second

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close button or ESC key
        // Update
        if raylib.IsKeyDown(.RIGHT) { ballPosition.x += 2.0 }
        if raylib.IsKeyDown(.LEFT) { ballPosition.x -= 2.0 }
        if raylib.IsKeyDown(.UP) { ballPosition.y -= 2.0 }
        if raylib.IsKeyDown(.DOWN) { ballPosition.y += 2.0 }

        // Draw
        raylib.BeginDrawing()

            raylib.ClearBackground(raylib.RAYWHITE)

            raylib.DrawText("Move the ball with the arrow keys", 10, 10, 20, raylib.BLACK)

            raylib.DrawCircleV(ballPosition, 50, raylib.MAROON)

        raylib.EndDrawing()
    }
    // De-Initialization
}