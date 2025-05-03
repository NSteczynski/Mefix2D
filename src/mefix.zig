const std = @import("std");
const window = @import("core/window.zig");

pub fn main() void {
    window.init(800, 600, "mefix2D");
    defer window.deinit();

    while (!window.shouldClose()) {
        window.pollEvents();
        defer window.swapBuffers();
    }
}
