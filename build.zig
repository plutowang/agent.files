const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zlap = b.dependency("zlap", .{
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "agentc",
        .root_module = b.createModule(.{
            .root_source_file = b.path("agentc/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zlap", .module = zlap.module("zlap") },
            },
        }),
    });

    // Install the executable to zig-out/bin/
    b.installArtifact(exe);

    // Create run step for `zig build run`
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the setup tool");
    run_step.dependOn(&run_cmd.step);

    // Allow passing arguments: `zig build run -- --help`
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // Create test step for `zig build test`
    const exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });

    const run_exe_tests = b.addRunArtifact(exe_tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_exe_tests.step);
}
