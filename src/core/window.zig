const std = @import("std");
const glfw = @import("glfw");

var window: glfw.Window = undefined;

pub fn init(width: u32, height: u32, title: [*:0]const u8) void {
    if (!glfw.init(.{})) {
        std.log.err("Failed to initialize GLFW!", .{});
        return std.process.exit(0);
    }

    window = glfw.Window.create(width, height, title, null, null, .{
        .client_api = .opengl_api,
        .context_version_major = 4,
        .context_version_minor = 6,
        .opengl_profile = .opengl_core_profile,
        .opengl_forward_compat = true,
    }) orelse {
        std.log.err("Failed to create GLFW window!", .{});
        return std.process.exit(0);
    };

    window.setInputModeCursor(.disabled);

    glfw.makeContextCurrent(window);
    glfw.swapInterval(0);
}

pub fn deinit() void {
    window.destroy();
    glfw.terminate();
}

pub fn setRefresh(refresh: fn (window: glfw.Window) void) void {
    window.setRefreshCallback(refresh);
}

pub fn getAspectRation() f32 {
    const size = window.getSize();
    return @floatFromInt(size.width / size.height);
}

pub fn getCursorPos() glfw.Window.CursorPos {
    return window.getCursorPos();
}

pub fn shouldClose() bool {
    return window.shouldClose();
}

pub fn close() void {
    window.setShouldClose(true);
}

pub fn setTitle(title: [*:0]const u8) void {
    window.setTitle(title);
}

pub fn getKey(key: glfw.Key) glfw.Action {
    return window.getKey(key);
}

pub fn isPressed(key: glfw.Key) bool {
    return window.getKey(key) == .press;
}

pub fn pollEvents() void {
    glfw.pollEvents();
}

pub fn swapBuffers() void {
    window.swapBuffers();
}
