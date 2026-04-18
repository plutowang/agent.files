const std = @import("std");
const fs = std.fs;
const Io = std.Io;

const zlap = @import("zlap");

fn backup(io: Io, log: *zlap.Logger, allocator: std.mem.Allocator, file_path: []const u8) !bool {
    const work_dir = Io.Dir.cwd();
    const file = work_dir.openFile(io, file_path, .{}) catch |err| switch (err) {
        error.FileNotFound => return false,
        else => return err,
    };
    defer file.close(io);

    const stat = file.stat(io) catch return false;
    if (stat.kind == .sym_link) return false;

    const now = std.Io.Clock.real.now(io);
    const ts = now.toNanoseconds();
    const backup_path = try std.fmt.allocPrint(allocator, "{s}.backup.{d}", .{ file_path, ts });
    defer allocator.free(backup_path);

    try work_dir.rename(file_path, work_dir, backup_path, io);
    log.warning("Backed up existing {s} to {s}", .{ file_path, backup_path });

    return true;
}

pub fn createSymlink(
    io: Io,
    source_path: []const u8,
    target_path: []const u8,
    name: []const u8,
    allocator: std.mem.Allocator,
    dry_run: bool,
    log: *zlap.Logger,
) !void {
    log.info("Setting up {s}", .{name});

    const work_dir = Io.Dir.cwd();

    // Verify source exists
    work_dir.access(io, source_path, .{}) catch {
        log.warning("Source does not exist: {s}", .{source_path});
        return error.SourceNotFound;
    };

    // Validate source kind: only allow regular files and directories.
    // Reject symlinks to prevent chained symlink attacks (e.g., source -> ~/.ssh/id_rsa).
    const source_stat = work_dir.statFile(io, source_path, .{}) catch {
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
        work_dir.createDirPath(io, dir) catch |err| switch (err) {
            error.PathAlreadyExists => {},
            else => return err,
        };
    }

    // Check if target already exists and what it points to
    var link_buffer: [fs.max_path_bytes]u8 = undefined;
    if (work_dir.readLink(io, target_path, &link_buffer)) |len| {
        const current_target = link_buffer[0..len];
        if (std.mem.eql(u8, current_target, source_path)) {
            log.success("{s}: already linked - {s} -> {s}", .{ name, target_path, source_path });
            return;
        }
        log.warning("Replacing existing symlink: {s} -> {s}", .{ target_path, current_target });
        try work_dir.deleteFile(io, target_path);
    } else |err| switch (err) {
        error.FileNotFound => {},
        error.NotLink => {
            _ = try backup(io, log, allocator, target_path);
        },
        else => return err,
    }

    try work_dir.symLink(io, source_path, target_path, .{});
    log.success("{s}: linked - {s} -> {s}", .{ name, target_path, source_path });
}
