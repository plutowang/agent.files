const std = @import("std");
const fs = std.fs;
const zlap = @import("zlap");

fn backup(log: *zlap.Logger, allocator: std.mem.Allocator, file_path: []const u8) !bool {
    const work_dir = fs.cwd();
    const file = work_dir.openFile(file_path, .{}) catch |err| switch (err) {
        error.FileNotFound => return false,
        else => return err,
    };
    defer file.close();

    const stat = file.stat() catch return false;
    if (stat.kind == .sym_link) return false;

    const ts = std.time.nanoTimestamp();
    const backup_path = try std.fmt.allocPrint(allocator, "{s}.backup.{d}", .{ file_path, ts });
    defer allocator.free(backup_path);

    try work_dir.rename(file_path, backup_path);
    log.warning("Backed up existing {s} to {s}", .{ file_path, backup_path });

    return true;
}

pub fn createSymlink(
    source_path: []const u8,
    target_path: []const u8,
    name: []const u8,
    allocator: std.mem.Allocator,
    dry_run: bool,
    log: *zlap.Logger,
) !void {
    log.info("Setting up {s}", .{name});

    const work_dir = fs.cwd();

    // Verify source exists
    work_dir.access(source_path, .{}) catch {
        log.warning("Source does not exist: {s}", .{source_path});
        return error.SourceNotFound;
    };

    // Validate source kind: only allow regular files and directories.
    // Reject symlinks to prevent chained symlink attacks (e.g., source -> ~/.ssh/id_rsa).
    const source_stat = work_dir.statFile(source_path) catch {
        log.warning("Could not stat source: {s}", .{source_path});
        return error.SourceNotFound;
    };
    if (source_stat.kind != .file and source_stat.kind != .directory) {
        log.err("Source is not a regular file or directory: {s} (kind: {s})", .{ source_path, @tagName(source_stat.kind) });
        return error.InvalidSourceKind;
    }

    if (dry_run) {
        log.info("Would link {s} -> {s}", .{ target_path, source_path });
        return;
    }

    // Create parent directories if needed
    if (fs.path.dirname(target_path)) |dir| {
        work_dir.makePath(dir) catch |err| switch (err) {
            error.PathAlreadyExists => {},
            else => return err,
        };
    }

    // Check if target already exists and what it points to
    var link_buffer: [fs.max_path_bytes]u8 = undefined;
    if (work_dir.readLink(target_path, &link_buffer)) |current_target| {
        if (std.mem.eql(u8, current_target, source_path)) {
            log.info("{s}: already linked - {s} -> {s}", .{ name, target_path, source_path });
            return;
        }
        log.warning("Replacing existing symlink: {s} -> {s}", .{ target_path, current_target });
        try work_dir.deleteFile(target_path);
    } else |err| switch (err) {
        error.FileNotFound => {},
        error.NotLink => {
            _ = try backup(log, allocator, target_path);
        },
        else => return err,
    }

    try work_dir.symLink(source_path, target_path, .{});
    log.info("{s}: linked - {s} -> {s}", .{ name, target_path, source_path });
}
