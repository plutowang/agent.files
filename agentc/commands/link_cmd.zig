const std = @import("std");
const fs = std.fs;
const Io = std.Io;

const zlap = @import("zlap");

const config = @import("../core/config.zig");
const context = @import("../core/context.zig");
const symlink = @import("../core/symlink.zig");

pub fn handler(parser: *zlap.Parser) !void {
    const allocator = parser.allocator;
    const log = parser.logger;
    const io = context.init.io;

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    // Get target from positional argument
    const target_name = parser.getArg(0) orelse {
        log.err("Error: target required (opencode, cursor, or copilot)", .{});
        return;
    };

    const target = config.findTarget(target_name) orelse {
        log.err("Error: unknown target '{s}'. Available: opencode, cursor, copilot", .{target_name});
        return;
    };

    const dry_run = parser.getFlag("dry-run");

    if (dry_run) {
        log.info("Starting link for {s} (dry-run)...", .{target.name});
    } else {
        log.info("Starting link for {s}...", .{target.name});
    }

    // Resolve HOME directory
    const home_dir = context.init.environ_map.get("HOME") orelse {
        log.err("Error: HOME environment variable not set", .{});
        return;
    };

    // Resolve current working directory absolute path
    const cwd = std.process.currentPathAlloc(io, alloc) catch |err| {
        log.err("Failed to get current directory: {s}", .{@errorName(err)});
        return;
    };

    // --- Symlink subdirectories ---
    for (target.subdirs) |subdir| {
        const source_path = try fs.path.join(alloc, &.{ cwd, "dist", target.source_dir, subdir });
        const dest_path = try fs.path.join(alloc, &.{ home_dir, target.config_base, subdir });

        symlink.createSymlink(io, source_path, dest_path, subdir, alloc, dry_run, log) catch |err| switch (err) {
            error.SourceNotFound => continue,
            else => log.err("Failed to link {s}: {s}", .{ subdir, @errorName(err) }),
        };
    }

    // --- Symlink root-level files (e.g. AGENTS.md, *.json) ---
    const dist_target_path = try fs.path.join(alloc, &.{ "dist", target.source_dir });
    var dist_dir = Io.Dir.cwd().openDir(io, dist_target_path, .{ .iterate = true }) catch |err| {
        log.warning("Could not open {s}: {s}", .{ dist_target_path, @errorName(err) });
        log.success("Done.", .{});
        return;
    };
    defer dist_dir.close(io);

    var it = dist_dir.iterate();
    while (it.next(io) catch null) |entry| {
        if (entry.kind != .file) continue;

        const source_path = try fs.path.join(alloc, &.{ cwd, "dist", target.source_dir, entry.name });
        const dest_path = blk: {
            for (target.file_dest_overrides) |override| {
                if (std.mem.eql(u8, override.name, entry.name)) {
                    break :blk try fs.path.join(alloc, &.{ home_dir, override.dest_relative_home });
                }
            }
            break :blk try fs.path.join(alloc, &.{ home_dir, target.config_base, entry.name });
        };

        symlink.createSymlink(io, source_path, dest_path, entry.name, alloc, dry_run, log) catch |err| switch (err) {
            error.SourceNotFound => continue,
            else => log.err("Failed to link {s}: {s}", .{ entry.name, @errorName(err) }),
        };
    }

    log.success("Done.", .{});
}
