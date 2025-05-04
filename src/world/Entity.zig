const Sprite = @import("../graphics/Sprite.zig");

const Self = @This();

position: [2]f32 = .{ 0, 0 },
scale: f32 = 1,
sprite: Sprite,

pub fn update(self: *Self) void {
    _ = self;
}

pub fn render(self: Self) void {
    self.sprite.render([3][3]f32{
        .{ self.scale, 0, self.position[0] },
        .{ 0, self.scale, self.position[1] },
        .{ 0, 0, 1 },
    });
}
