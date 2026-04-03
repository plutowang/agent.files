const std = @import("std");
const fs = std.fs;
const zlap = @import("zlap");
const config = @import("../core/config.zig");
const fs_utils = @import("../core/fs_utils.zig");

pub fn handler(parser: *zlap.Parser) error{OutOfMemory}!void {
    const allocator = parser.allocator;
    const log = parser.logger;

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const dry_run = parser.getFlag("dry-run");

    if (dry_run) {
        log.info("Starting build (dry-run)...", .{});
    } else {
        log.info("Starting build...", .{});

        // Delete dist/ if it exists
        fs.cwd().deleteTree("dist") catch |err| {
            if (err != error.FileNotFound) {
                log.err("Failed to delete dist/: {s}", .{@errorName(err)});
                return;
            }
        };

        // Create dist/
        fs.cwd().makePath("dist") catch |err| {
            log.err("Failed to create dist/: {s}", .{@errorName(err)});
            return;
        };
    }

    var total_files: usize = 0;

    // Build each IDE target (opencode, cursor)
    for (config.targets) |target| {
        const dest_dir = fs.path.join(alloc, &.{ "dist", target.source_dir }) catch {
            log.err("Failed to construct dest path", .{});
            return;
        };

        log.info("Building {s}...", .{target.name});

        const count = fs_utils.buildTargetDir(alloc, target.source_dir, dest_dir, dry_run, log) catch |err| {
            log.err("Failed to build {s}: {s}", .{ target.name, @errorName(err) });
            return;
        };
        total_files += count;

        log.info("Processed {d} files for {s}", .{ count, target.name });
    }

    // Copy shared skills to both targets
    const skills_source = "_core/skills";
    for (config.targets) |target| {
        const skills_dest = fs.path.join(alloc, &.{ "dist", target.source_dir, "skills" }) catch {
            log.err("Failed to construct skills dest path", .{});
            return;
        };

        log.info("Copying skills to {s}/skills...", .{target.name});

        const count = fs_utils.copyDirRecursive(alloc, skills_source, skills_dest, dry_run, log) catch |err| {
            log.err("Failed to copy skills: {s}", .{@errorName(err)});
            return;
        };
        total_files += count;

        log.info("Processed {d} skill files to dist/{s}/skills", .{ count, target.name });
    }

    log.info("Done. {d} files processed.", .{total_files});
}
