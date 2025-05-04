const std = @import("std");
const gl = @import("zgl");

const Self = @This();

program: gl.Program,

pub fn init(vertex_path: []const u8, fragment_path: []const u8) Self {
    const program = gl.createProgram();

    const vertex_shader = createShader(vertex_path, .vertex);
    defer vertex_shader.delete();
    const fragment_shader = createShader(fragment_path, .fragment);
    defer fragment_shader.delete();

    program.attach(vertex_shader);
    program.attach(fragment_shader);
    program.link();

    return Self{
        .program = program,
    };
}

pub fn initEmbedded(vertex: [:0]const u8, fragment: [:0]const u8) Self {
    const program = gl.createProgram();

    const vertex_shader = compileShader(vertex, .vertex);
    const fragment_shader = compileShader(fragment, .fragment);

    program.attach(vertex_shader);
    program.attach(fragment_shader);
    program.link();

    return Self{
        .program = program,
    };
}

pub fn deinit(self: Self) void {
    self.program.delete();
}

fn createShader(path: []const u8, shader_type: gl.ShaderType) gl.Shader {
    const file = std.fs.cwd().openFile(path, .{}) catch |err| {
        std.log.err("Failed to open {s} shader {s}: {!}", .{ @tagName(shader_type), path, err });
        return gl.Shader.invalid;
    };
    defer file.close();

    var buf: [1024]u8 = undefined;
    const size = file.readAll(&buf) catch |err| {
        std.log.err("Failed to read {s} shader {s}: {!}", .{ @tagName(shader_type), path, err });
        return gl.Shader.invalid;
    };

    return compileShader(buf[0..size], shader_type);
}

fn compileShader(data: []const u8, shader_type: gl.ShaderType) gl.Shader {
    const shader = gl.createShader(shader_type);
    shader.source(1, &[1][]const u8{data});
    shader.compile();

    if (shader.get(.compile_status) == 0) {
        shader.delete();

        const info_log = shader.getCompileLog(std.heap.page_allocator) catch unreachable;
        defer std.heap.page_allocator.free(info_log);

        std.log.err("Failed to compile {s} shader: {s}", .{ @tagName(shader_type), info_log });
        return gl.Shader.invalid;
    }

    return shader;
}

pub fn use(self: Self) void {
    self.program.use();
}

pub fn attribLocation(self: Self, name: [:0]const u8) ?u32 {
    return self.program.attribLocation(name);
}

pub fn uniformLocation(self: Self, name: [:0]const u8) ?u32 {
    return self.program.uniformLocation(name);
}
