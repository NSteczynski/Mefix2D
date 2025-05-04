pub const graphics = @import("graphics/graphics.zig");
pub const core = @import("core/core.zig");

pub fn init(width: u32, height: u32, title: [*:0]const u8) void {
    core.init(width, height, title);
    graphics.init();
}

pub fn deinit() void {
    core.deinit();
    graphics.deinit();
}
