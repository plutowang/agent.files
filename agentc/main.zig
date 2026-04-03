const std = @import("std");
const zlap = @import("zlap");
const build_cmd = @import("commands/build_cmd.zig");
const link_cmd = @import("commands/link_cmd.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var logger = zlap.Logger{};

    var parser = zlap.Parser.init(
        allocator,
        "agentc",
        "Agent OS compiler and linker",
        &logger,
    );
    defer parser.deinit();

    // Build subcommand
    const build_sub = try parser.subCommand("build", "Compile source files to dist/", build_cmd.handler);
    _ = build_sub.flag('n', "dry-run", "Show what would be done without writing any files");

    // Link subcommand with required positional argument
    const link_sub = try parser.subCommand("link", "Symlink dist/ to IDE config directories", link_cmd.handler);
    _ = link_sub.arg("target", "Target IDE: opencode or cursor", true);
    _ = link_sub.flag('n', "dry-run", "Show what would be done without creating any symlinks");

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    try parser.parse(args);
    try parser.execute();
}
