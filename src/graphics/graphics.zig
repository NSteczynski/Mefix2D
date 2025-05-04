const renderer = @import("renderer.zig");

pub const Texture = @import("Texture.zig");
pub const Sprite = @import("Sprite.zig");
pub const Box = @import("Box.zig");

pub fn init() void {
    renderer.init();
}

pub fn deinit() void {
    renderer.deinit();
}
