const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/mefix.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "mefix",
        .root_module = exe_mod,
        .use_llvm = false,
        .use_lld = false,
    });

    b.installArtifact(exe);

    const glfw_dep = b.dependency("glfw", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("glfw", glfw_dep.module("glfw"));

    const zgl = b.dependency("zgl", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("zgl", zgl.module("zgl"));

    const zigimg_dependency = b.dependency("zigimg", .{
        .target = target,
        .optimize = optimize,
    });

    exe.root_module.addImport("zigimg", zigimg_dependency.module("zigimg"));

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
