const std = @import("std");

/// Maps a root-level filename in dist/<target>/ to an explicit symlink
/// destination (relative to $HOME), overriding the default config_base path.
pub const FileDestOverride = struct {
    name: []const u8,
    dest_relative_home: []const u8,
};

pub const IdeTarget = struct {
    name: []const u8,
    source_dir: []const u8,
    config_base: []const u8,
    subdirs: []const []const u8,
    file_dest_overrides: []const FileDestOverride,
};

pub const targets = [_]IdeTarget{
    .{
        .name = "opencode",
        .source_dir = "opencode",
        .config_base = ".config/opencode",
        .subdirs = &.{ "agents", "rules", "commands", "skills", "plugins", "bin" },
        .file_dest_overrides = &.{},
    },
    .{
        .name = "cursor",
        .source_dir = "cursor",
        .config_base = ".cursor",
        .subdirs = &.{ "agents", "rules", "commands", "skills" },
        .file_dest_overrides = &.{
            .{ .name = "settings.json", .dest_relative_home = "Library/Application Support/Cursor/User/settings.json" },
            .{ .name = "extensions.json", .dest_relative_home = "Library/Application Support/Cursor/User/extensions.json" },
        },
    },
};

pub fn findTarget(name: []const u8) ?IdeTarget {
    for (targets) |target| {
        if (std.mem.eql(u8, target.name, name)) {
            return target;
        }
    }
    return null;
}
