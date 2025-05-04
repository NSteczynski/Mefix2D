const gl = @import("zgl");
const renderer = @import("../graphics/renderer.zig");

const Self = @This();

position: [2]f32 = .{ 0, 0 },

pub const new = Self{};

pub fn render(self: Self) void {
    // Move the entities to opposite direction than camera and downscale the coords by tenth.
    // Last row contains all zeros instead of (0, 0, 1) to zero the z-index otherwise it will not render.
    renderer.setMatrixUniform("u_View", [3][3]f32{
        .{ 0.1, 0, -self.position[0] },
        .{ 0, 0.1, -self.position[1] },
        .{ 0, 0, 0 },
    });
}
