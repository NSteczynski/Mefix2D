const std = @import("std");
const gl = @import("zgl");
const glfw = @import("glfw");

pub const window = @import("window.zig");

fn glGetProcAddress(_: glfw.GLProc, proc: [:0]const u8) ?gl.binding.FunctionPointer {
    return glfw.getProcAddress(proc);
}

pub fn init(width: u32, height: u32, title: [*:0]const u8) void {
    window.init(width, height, title);

    const proc: glfw.GLProc = undefined;
    gl.loadExtensions(proc, glGetProcAddress) catch |err| {
        std.log.err("Failed to load OpenGL functions: {!}!", .{err});
        return std.process.exit(0);
    };

    window.setRefresh(refresh);

    gl.enable(.depth_test);
    gl.depthFunc(.less);

    gl.enable(.cull_face);
    gl.cullFace(.back);
    gl.frontFace(.ccw);

    gl.enable(.blend);
    gl.blendFunc(.src_alpha, .one_minus_src_alpha);

    gl.polygonMode(.front_and_back, .fill);
}

pub fn clearBackground() void {
    gl.clearColor(0.53, 0.81, 0.92, 1.0);
    gl.clear(.{ .color = true, .depth = true });
}

fn refresh(glfw_window: glfw.Window) void {
    const size = glfw_window.getSize();
    gl.viewport(0, 0, size.width, size.height);
}

pub fn deinit() void {
    window.deinit();
}
