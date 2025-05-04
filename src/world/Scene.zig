const std = @import("std");
const Entity = @import("Entity.zig");
const Camera = @import("Camera.zig");

const Self = @This();

entities: std.ArrayListUnmanaged(Entity),
camera: Camera = .new,

pub fn init(allocator: std.mem.Allocator) !Self {
    var entities: std.ArrayListUnmanaged(Entity) = .empty;
    try entities.ensureTotalCapacity(allocator, 1024);

    return Self{
        .entities = entities,
    };
}

pub fn update(self: Self) void {
    for (self.entities.items) |*entity|
        entity.update();
}

pub fn render(self: Self) void {
    self.camera.render();
    for (self.entities.items) |entity|
        entity.render();
}

pub fn deinit(self: *Self, allocator: std.mem.Allocator) void {
    self.entities.deinit(allocator);
}
