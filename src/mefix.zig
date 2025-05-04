const window = @import("core/window.zig");
const gl = @import("core/gl.zig");

pub fn init() void {
    window.init(800, 600, "mefix2D");
    gl.init();
}

pub fn loop() bool {
    window.pollEvents();
    defer window.swapBuffers();

    // Render
    {
        gl.clearBackground();
    }

    return !window.shouldClose();
}

pub fn deinit() void {
    window.deinit();
}
