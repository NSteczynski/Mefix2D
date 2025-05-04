const window = @import("core/window.zig");
const gl = @import("core/gl.zig");

pub fn main() void {
    window.init(800, 600, "mefix2D");
    defer window.deinit();
    gl.init();

    while (!window.shouldClose()) {
        window.pollEvents();
        defer window.swapBuffers();

        // Render
        {
            gl.clearBackground();
        }
    }
}
