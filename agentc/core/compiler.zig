const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const Io = std.Io;

const zlap = @import("zlap");

const context = @import("context.zig");

const max_file_size = 1024 * 1024; // 1MB

/// Maximum nesting depth for <!-- @import --> chains. The circular guard below
/// only catches cycles; a deep acyclic chain would otherwise recurse until the
/// stack overflows. 16 is far above any legitimate macro hierarchy.
const max_import_depth = 16;

/// Recursive macro expansion: replaces <!-- @import path/to/file.md -->
/// with the contents of that file, recursively resolving nested imports.
pub fn resolveImports(
    allocator: mem.Allocator,
    filepath: []const u8,
    visited: *std.StringHashMap(void),
    log: *zlap.Logger,
) ![]const u8 {
    // Depth guard. `visited` is a push/pop recursion stack (see the defer
    // below), so its count is exactly the number of enclosing frames.
    if (visited.count() >= max_import_depth) {
        log.err(
            "Import nesting exceeded {d} levels at {s}",
            .{ max_import_depth, filepath },
        );
        return error.ImportDepthExceeded;
    }

    // Circular import guard
    if (visited.contains(filepath)) {
        log.err("Circular import detected at {s}", .{filepath});
        return error.CircularImport;
    }
    try visited.put(filepath, {});
    defer _ = visited.remove(filepath);
    errdefer _ = visited.remove(filepath);

    // Read source file using readFileAlloc (opens, reads, and closes the file)
    const content = try Io.Dir.cwd().readFileAlloc(context.init.io, filepath, allocator, .limited(max_file_size));
    errdefer allocator.free(content);

    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    const tag_start = "<!-- @import ";
    const tag_end = " -->";

    var cursor: usize = 0;
    while (mem.findPos(u8, content, cursor, tag_start)) |start_idx| {
        // Write text before the import tag
        try result.appendSlice(allocator, content[cursor..start_idx]);

        // Find the closing tag
        const end_idx = mem.findPos(u8, content, start_idx + tag_start.len, tag_end) orelse {
            return error.MalformedImportTag;
        };

        // Extract and trim the import path
        const import_path = mem.trim(
            u8,
            content[start_idx + tag_start.len .. end_idx],
            " \t\r\n",
        );

        // Validate import path: reject directory traversal and absolute paths.
        // This prevents <!-- @import ../../etc/passwd --> style attacks.
        if (mem.startsWith(u8, import_path, "/") or
            mem.startsWith(u8, import_path, "\\") or
            mem.eql(u8, import_path, "..") or
            mem.startsWith(u8, import_path, "../") or
            mem.startsWith(u8, import_path, "..\\") or
            mem.find(u8, import_path, "/../") != null or
            mem.find(u8, import_path, "\\..\\") != null)
        {
            log.err("Rejected unsafe import path: {s} (in {s})", .{ import_path, filepath });
            return error.AccessDenied;
        }

        // Recursively resolve the imported file
        const imported = try resolveImports(allocator, import_path, visited, log);
        try result.appendSlice(allocator, imported);
        allocator.free(imported);

        cursor = end_idx + tag_end.len;
    }

    // Write any remaining text after the last import tag
    try result.appendSlice(allocator, content[cursor..]);

    return try result.toOwnedSlice(allocator);
}
