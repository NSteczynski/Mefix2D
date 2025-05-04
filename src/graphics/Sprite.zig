const Texture = @import("Texture.zig");
const renderer = @import("renderer.zig");

const Self = @This();

texture: Texture,

pub fn render(self: Self, matrix: [3][3]f32) void {
    self.texture.bind();
    renderer.setMatrixUniform("u_Mat", matrix);
    renderer.setVec4Uniform("color", .{ 1.0, 1.0, 1.0, 1.0 });
    renderer.draw();
}
