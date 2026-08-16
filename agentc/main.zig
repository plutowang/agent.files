const std = @import("std");

const zlap = @import("zlap");

const build_cmd = @import("commands/build_cmd.zig");
const link_cmd = @import("commands/link_cmd.zig");
const context = @import("core/context.zig");
const fs_utils = @import("core/fs_utils.zig");

pub fn main(init: std.process.Init) !void {
    context.init = init;
    const allocator = init.arena.allocator();

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
    _ = link_sub.arg("target", "Target IDE: opencode, cursor, or copilot", true);
    _ = link_sub.flag('n', "dry-run", "Show what would be done without creating any symlinks");

    const args = try init.minimal.args.toSlice(allocator);

    try parser.parse(args);
    try parser.execute();
}

test "isBinaryContent detects binary content" {
    try std.testing.expect(!fs_utils.isBinaryContent("plain text"));
    try std.testing.expect(!fs_utils.isBinaryContent(""));
    try std.testing.expect(fs_utils.isBinaryContent(&.{ 'a', 'b', 0, 'c' }));
    try std.testing.expect(fs_utils.isBinaryContent(&.{0}));
}
