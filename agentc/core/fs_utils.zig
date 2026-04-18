const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const Io = std.Io;

const zlap = @import("zlap");

const compiler = @import("compiler.zig");
const context = @import("context.zig");

/// Returns true if the entry should be excluded from the build.
/// Skips files under any `.examples/` directory component, and skips
/// root-level `README.md` files.
fn shouldSkip(entry_path: []const u8) bool {
    // Skip README.md at root level
    if (mem.eql(u8, entry_path, "README.md") or mem.eql(u8, entry_path, ".DS_Store")) return true;

    // Skip anything inside a .examples/ directory
    var it = mem.splitScalar(u8, entry_path, fs.path.sep);
    while (it.next()) |component| {
        if (mem.eql(u8, component, ".examples")) return true;
    }

    return false;
}

fn copyFile(io: Io, allocator: mem.Allocator, source_path: []const u8, dest_path: []const u8) !void {
    // Read the source file and write it to the destination.
    const content = try Io.Dir.cwd().readFileAlloc(io, source_path, allocator, .limited(1024 * 1024 * 100));
    defer allocator.free(content);

    const dest = try Io.Dir.cwd().createFile(io, dest_path, .{});
    defer dest.close(io);

    try dest.writeStreamingAll(io, content);
}

fn compileFile(allocator: mem.Allocator, io: Io, source_path: []const u8, dest_path: []const u8, log: *zlap.Logger) !void {
    var visited = std.StringHashMap(void).init(allocator);
    defer visited.deinit();

    const resolved = try compiler.resolveImports(allocator, source_path, &visited, log);
    defer allocator.free(resolved);

    const dest = try Io.Dir.cwd().createFile(io, dest_path, .{});
    defer dest.close(io);

    try dest.writeStreamingAll(io, resolved);
}

/// Walks source_dir, compiles or copies each file to the mirrored path inside
/// dest_dir. JSON files are copied verbatim; all others are run through
/// resolveImports. Skips `.examples/` subtrees and root `README.md`.
/// When dry_run is true, logs actions but writes nothing.
/// Returns the number of files processed.
pub fn buildTargetDir(
    allocator: mem.Allocator,
    source_dir_path: []const u8,
    dest_dir_path: []const u8,
    dry_run: bool,
    log: *zlap.Logger,
) !usize {
    const io = context.init.io;
    var count: usize = 0;

    var source_dir = try Io.Dir.cwd().openDir(io, source_dir_path, .{ .iterate = true });
    defer source_dir.close(io);

    var walker = try source_dir.walk(allocator);
    defer walker.deinit();

    while (try walker.next(io)) |entry| {
        if (shouldSkip(entry.path)) continue;

        if (entry.kind == .file) {
            // entry.path is relative to the opened dir; build full source path
            const source_path = try fs.path.join(allocator, &.{ source_dir_path, entry.path });
            defer allocator.free(source_path);

            // Mirror the same relative path into dest_dir
            const dest_path = try fs.path.join(allocator, &.{ dest_dir_path, entry.path });
            defer allocator.free(dest_path);

            const is_json = mem.endsWith(u8, entry.path, ".json");

            if (dry_run) {
                if (is_json) {
                    log.info("Would copy   {s}/{s}", .{ source_dir_path, entry.path });
                } else {
                    log.info("Would compile {s}/{s}", .{ source_dir_path, entry.path });
                }
            } else {
                if (fs.path.dirname(dest_path)) |parent| {
                    try Io.Dir.cwd().createDirPath(io, parent);
                }
                if (is_json) {
                    try copyFile(io, allocator, source_path, dest_path);
                    log.success("Copied   {s}/{s}", .{ source_dir_path, entry.path });
                } else {
                    try compileFile(allocator, io, source_path, dest_path, log);
                    log.success("Compiled {s}/{s}", .{ source_dir_path, entry.path });
                }
            }
            count += 1;
        }
    }

    return count;
}

/// Recursively copies entire source_dir tree to dest_dir.
/// Skips `.examples/` subtrees. No import resolution — raw copy only.
/// When dry_run is true, logs actions but writes nothing.
/// Returns the number of files processed.
pub fn copyDirRecursive(
    allocator: mem.Allocator,
    source_dir_path: []const u8,
    dest_dir_path: []const u8,
    dry_run: bool,
    log: *zlap.Logger,
) !usize {
    const io = context.init.io;
    var count: usize = 0;

    var source_dir = try Io.Dir.cwd().openDir(io, source_dir_path, .{ .iterate = true });
    defer source_dir.close(io);

    var walker = try source_dir.walk(allocator);
    defer walker.deinit();

    while (try walker.next(io)) |entry| {
        if (shouldSkip(entry.path)) continue;

        if (entry.kind == .file) {
            const source_path = try fs.path.join(allocator, &.{ source_dir_path, entry.path });
            defer allocator.free(source_path);

            const dest_path = try fs.path.join(allocator, &.{ dest_dir_path, entry.path });
            defer allocator.free(dest_path);

            if (dry_run) {
                log.info("Would copy skill {s}/{s}", .{ source_dir_path, entry.path });
            } else {
                if (fs.path.dirname(dest_path)) |parent| {
                    try Io.Dir.cwd().createDirPath(io, parent);
                }
                try copyFile(io, allocator, source_path, dest_path);
                log.success("Copied skill {s}/{s}", .{ source_dir_path, entry.path });
            }
            count += 1;
        }
    }

    return count;
}
