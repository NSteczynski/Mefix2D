const window = @import("core/window.zig");
const gl = @import("core/gl.zig");

pub fn init(width: u32, height: u32, title: [*:0]const u8) void {
    window.init(width, height, title);
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
