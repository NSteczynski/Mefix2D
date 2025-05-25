pub const core = @import("core/core.zig");

pub fn init(width: u32, height: u32, title: [*:0]const u8) void {
    core.init(width, height, title);
}

pub fn deinit() void {
    core.deinit();
}
