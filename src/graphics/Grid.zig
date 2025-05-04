const renderer = @import("renderer.zig");

const Self = @This();

size: f32 = 10,

const new = Self{};

pub fn render(self: Self) void {
    _ = self;
}
