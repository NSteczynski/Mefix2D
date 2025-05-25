const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.addModule("mefix", .{
        .root_source_file = b.path("src/mefix.zig"),
        .target = target,
        .optimize = optimize,
    });

    const glfw_dep = b.dependency("glfw", .{
        .target = target,
        .optimize = optimize,
    });
    module.addImport("glfw", glfw_dep.module("glfw"));

    const zgl = b.dependency("zgl", .{
        .target = target,
        .optimize = optimize,
    });
    module.addImport("zgl", zgl.module("zgl"));
}
