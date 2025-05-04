const window = @import("core/window.zig");
const gl = @import("core/gl.zig");
const renderer = @import("graphics/renderer.zig");

pub const Texture = @import("graphics/Texture.zig");
pub const Sprite = @import("graphics/Sprite.zig");

pub fn init(width: u32, height: u32, title: [*:0]const u8) void {
    window.init(width, height, title);
    gl.init();
    renderer.init();
}

pub fn loop() bool {
    window.pollEvents();
    window.swapBuffers();

    // Render
    {
        gl.clearBackground();
    }

    return !window.shouldClose();
}

pub fn deinit() void {
    window.deinit();
    renderer.deinit();
}
