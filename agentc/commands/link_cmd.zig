const std = @import("std");
const fs = std.fs;
const zlap = @import("zlap");
const config = @import("../core/config.zig");
const symlink = @import("../core/symlink.zig");

pub fn handler(parser: *zlap.Parser) !void {
    const allocator = parser.allocator;
    const log = parser.logger;

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    // Get target from positional argument
    const target_name = parser.getArg(0) orelse {
        log.err("Error: target required (opencode or cursor)", .{});
        return;
    };

    const target = config.findTarget(target_name) orelse {
        log.err("Error: unknown target '{s}'. Available: opencode, cursor", .{target_name});
        return;
    };

    const dry_run = parser.getFlag("dry-run");

    if (dry_run) {
        log.info("Starting link for {s} (dry-run)...", .{target.name});
    } else {
        log.info("Starting link for {s}...", .{target.name});
    }

    // Resolve HOME directory
    const home_dir = std.posix.getenv("HOME") orelse {
        log.err("Error: HOME environment variable not set", .{});
        return;
    };

    // Resolve current working directory absolute path
    const cwd = fs.cwd().realpathAlloc(alloc, ".") catch |err| {
        log.err("Failed to get current directory: {s}", .{@errorName(err)});
        return;
    };

    // --- Symlink subdirectories ---
    for (target.subdirs) |subdir| {
        const source_path = try fs.path.join(alloc, &.{ cwd, "dist", target.source_dir, subdir });
        const dest_path = try fs.path.join(alloc, &.{ home_dir, target.config_base, subdir });

        // Verify source exists before attempting link
        fs.cwd().access(source_path, .{}) catch {
            log.warning("Source does not exist, skipping {s}", .{source_path});
            continue;
        };

        symlink.createSymlink(source_path, dest_path, subdir, alloc, dry_run, log) catch |err| {
            log.err("Failed to link {s}: {s}", .{ subdir, @errorName(err) });
            continue;
        };
    }

    // --- Symlink root-level files (e.g. .cursorrules, AGENTS.md, *.json) ---
    const dist_target_path = try fs.path.join(alloc, &.{ "dist", target.source_dir });
    var dist_dir = fs.cwd().openDir(dist_target_path, .{ .iterate = true }) catch |err| {
        log.warning("Could not open {s}: {s}", .{ dist_target_path, @errorName(err) });
        log.info("Done.", .{});
        return;
    };
    defer dist_dir.close();

    var it = dist_dir.iterate();
    while (it.next() catch null) |entry| {
        if (entry.kind != .file) continue;

        const source_path = try fs.path.join(alloc, &.{ cwd, "dist", target.source_dir, entry.name });
        const dest_path = try fs.path.join(alloc, &.{ home_dir, target.config_base, entry.name });

        symlink.createSymlink(source_path, dest_path, entry.name, alloc, dry_run, log) catch |err| {
            log.err("Failed to link {s}: {s}", .{ entry.name, @errorName(err) });
            continue;
        };
    }

    log.info("Done.", .{});
}
