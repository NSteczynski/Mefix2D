const std = @import("std");
const gl = @import("zgl");
const Shader = @import("Shader.zig");

const Vertex = struct {
    position: a_Position,
    texcoord: a_Texcoord,

    pub const a_Position = [2]f32;
    pub const a_Texcoord = [2]f32;
};

const Quad = struct {
    vertices: []const Vertex,
    indices: []const u16,
};

const quad: Quad = .{
    .vertices = &[_]Vertex{
        Vertex{ .position = .{ -1, -1 }, .texcoord = .{ 0, 1 } },
        Vertex{ .position = .{ -1, 1 }, .texcoord = .{ 0, 0 } },
        Vertex{ .position = .{ 1, -1 }, .texcoord = .{ 1, 1 } },
        Vertex{ .position = .{ 1, 1 }, .texcoord = .{ 1, 0 } },
    },
    .indices = &[_]u16{ 1, 0, 2, 2, 3, 1 },
};

var vao: gl.VertexArray = undefined;
var vbo: gl.Buffer = undefined;
var ebo: gl.Buffer = undefined;
var shader: Shader = undefined;

pub fn init() void {
    vao = gl.genVertexArray();
    vao.bind();

    vbo = gl.genBuffer();
    vbo.bind(.array_buffer);
    vbo.data(Vertex, quad.vertices, .static_draw);

    ebo = gl.genBuffer();
    ebo.bind(.element_array_buffer);
    ebo.data(u16, quad.indices, .static_draw);

    shader = .initEmbedded(@embedFile("shaders/vertex.glsl"), @embedFile("shaders/fragment.glsl"));
    defer shader.use();
    enableAttrib("position", "a_Position");
    enableAttrib("texcoord", "a_Texcoord");
}

fn enableAttrib(comptime name: []const u8, comptime shader_type_name: [:0]const u8) void {
    const index = shader.attribLocation(shader_type_name) orelse
        return std.log.err("Shader is missing type: {s}!", .{shader_type_name});

    const size = @typeInfo(@field(Vertex, shader_type_name)).array.len;
    gl.vertexAttribPointer(index, size, .float, false, @sizeOf(Vertex), @offsetOf(Vertex, name));
    gl.enableVertexAttribArray(index);
}

pub fn draw() void {
    gl.drawElements(.triangles, quad.indices.len, .unsigned_short, 0);
}

pub fn drawLines() void {
    gl.drawElements(.line_strip, quad.indices.len, .unsigned_short, 0);
}

pub fn setMatrixUniform(name: [:0]const u8, matrix: [3][3]f32) void {
    const location = shader.uniformLocation(name) orelse
        return std.log.err("Shader is missing uniform: {s}!", .{name});
    gl.uniformMatrix3fv(location, true, &.{matrix});
}

pub fn setVec4Uniform(name: [:0]const u8, vec4: [4]f32) void {
    const location = shader.uniformLocation(name) orelse
        return std.log.err("Shader is missing uniform: {s}!", .{name});
    gl.uniform4fv(location, &.{vec4});
}

pub fn deinit() void {
    // For some reason it's not needed to delete them.

    // vao.delete();
    // vbo.delete();
    // ebo.delete();
    // shader.deinit();
}
