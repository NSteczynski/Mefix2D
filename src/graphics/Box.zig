const std = @import("std");
const renderer = @import("renderer.zig");

const Self = @This();

position: [2]f32,
size: f32,
color: [4]f32,

pub fn render(self: Self) void {
    renderer.setMatrixUniform("u_Mat", [3][3]f32{
        .{ self.size, 0, self.position[0] },
        .{ 0, self.size, self.position[1] },
        .{ 0, 0, 1 },
    });

    renderer.setVec4Uniform("color", self.color);
    renderer.drawLines();
}
