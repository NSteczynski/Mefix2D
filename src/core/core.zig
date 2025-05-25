const std = @import("std");
const zgl = @import("zgl");
const glfw = @import("glfw");

pub var window: glfw.Window = undefined;
pub const pollEvents = glfw.pollEvents;

fn glGetProcAddress(_: glfw.GLProc, proc: [:0]const u8) ?zgl.binding.FunctionPointer {
    return glfw.getProcAddress(proc);
}

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

    glfw.makeContextCurrent(window);
    glfw.swapInterval(0);

    const proc: glfw.GLProc = undefined;
    zgl.loadExtensions(proc, glGetProcAddress) catch |err| {
        std.log.err("Failed to load OpenGL functions: {!}!", .{err});
        return std.process.exit(0);
    };

    window.setRefreshCallback(refresh);

    zgl.enable(.depth_test);
    zgl.depthFunc(.less);

    zgl.enable(.cull_face);
    zgl.cullFace(.back);
    zgl.frontFace(.ccw);

    zgl.enable(.blend);
    zgl.blendFunc(.src_alpha, .one_minus_src_alpha);

    zgl.polygonMode(.front_and_back, .fill);
}

pub fn deinit() void {
    window.deinit();
}

pub fn clearBackground() void {
    zgl.clearColor(0.53, 0.81, 0.92, 1.0);
    zgl.clear(.{ .color = true, .depth = true });
}

fn refresh(w: glfw.Window) void {
    const size = w.getSize();
    zgl.viewport(0, 0, size.width, size.height);
}
