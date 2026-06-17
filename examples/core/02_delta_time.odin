package core

import "vendor:raylib"

delta_time :: proc() {
    // Initialization
    screenWidth : i32 : 800
    screenHeight : i32 : 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - delta time")
    defer raylib.CloseWindow() // Close window and OpenGL context

    currentFps : i32 = 60

    // Store the position for both of the circles
    deltaCircle : raylib.Vector2 = { 0, f32(screenHeight) / 3.0 }
    frameCircle : raylib.Vector2 = { 0, f32(screenHeight) * 2.0 / 3.0 }

    // The speed applied to both circles
    speed : f32 : 10.0
    circleRadius : f32 : 32

    raylib.SetTargetFPS(currentFps)

    // Main game loop
    for !raylib.WindowShouldClose() { // Detect window close or ESC key
        // Update
        // Adjust FPS target based on the mouse wheel
        mouseWheel := raylib.GetMouseWheelMove()
        if mouseWheel != 0 {
            currentFps += i32(mouseWheel)
            currentFps = max(0, currentFps)
            raylib.SetTargetFPS(currentFps)
        }

        // GetFrameTime() returns the time it took to draw the last frame, in seconds (usually called delta time)
        // Uses the delta time to make the circle look like it's moving at a "consistent" speed regardless of FPS

        // Multiply by 6.0 (an arbitrary value) in order to make the speed
        // visually closer to the other circle (at 60 fps), for comparison
        deltaCircle.x += raylib.GetFrameTime() * 6.0 * speed
        // This circle can move faster or slewer visually depending on FPS
        frameCircle.x += 0.1 * speed

        // If either circle is off screen, reset it back to start
        if deltaCircle.x > f32(screenWidth) { deltaCircle.x = 0 }
        if frameCircle.x > f32(screenWidth) { frameCircle.x = 0 }

        // Resset both circle positions
        if raylib.IsKeyPressed(.R) {
            deltaCircle.x = 0
            frameCircle.x = 0
        }

        // Draw
        raylib.BeginDrawing()
            raylib.ClearBackground(raylib.RAYWHITE)

            // Draw both circles to the screen
            raylib.DrawCircleV(deltaCircle, circleRadius, raylib.RED)
            raylib.DrawCircleV(frameCircle, circleRadius, raylib.BLUE)

            // Draw help text
            // Determine what help text to show depending on the current FPS target
            fpsText : cstring
            if currentFps < 0 { fpsText = raylib.TextFormat("FPS: unlimited (%i)", raylib.GetFPS()) }
            else { fpsText = raylib.TextFormat("FPS: %i (target: %i)", raylib.GetFPS(), currentFps) }
            raylib.DrawText(fpsText, 10, 10, 20, raylib.DARKGRAY)
            raylib.DrawText(raylib.TextFormat("Frame time: %02.02f ms", raylib.GetFrameTime()), 10, 30, 20, raylib.DARKGRAY)
            raylib.DrawText("Use the scroll wheel to change the fps limit, r to reset", 10, 50, 20, raylib.DARKGRAY)

            // Draw text above the circles
            raylib.DrawText("FUNC: x += GetFrameTime()*speed", 10, 90, 20, raylib.RED)
            raylib.DrawText("FUNC: x += speed", 10, 240, 20, raylib.BLUE)

        raylib.EndDrawing()
    }
    // De-Initialization
}