const Texture = @import("Texture.zig");
const renderer = @import("renderer.zig");

const Self = @This();

texture: Texture,

pub fn init(texture: Texture) Self {
    return Self{
        .texture = texture,
    };
}

pub fn render(self: Self) void {
    self.texture.bind();
    renderer.draw();
}

pub fn deinit(self: Self) void {
    _ = self;
}
