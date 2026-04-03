const std = @import("std");

pub const IdeTarget = struct {
    name: []const u8,
    source_dir: []const u8,
    config_base: []const u8,
    subdirs: []const []const u8,
};

pub const targets = [_]IdeTarget{
    .{
        .name = "opencode",
        .source_dir = "opencode",
        .config_base = ".config/opencode",
        .subdirs = &.{ "agents", "rules", "commands", "skills" },
    },
    .{
        .name = "cursor",
        .source_dir = "cursor",
        .config_base = ".cursor",
        .subdirs = &.{ "agents", "rules", "commands", "skills" },
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
