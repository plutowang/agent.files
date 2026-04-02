# Agent Constraints

## File & Codebase Access

**CRITICAL: `explore` is the SOLE agent authorized to use `glob`, `grep`, and `webfetch`.** These tools are disabled at
the tool-permission level for all other agents — this is not just policy, it is enforced by the runtime.

**Special case — `build` agent**: `build` has `read` enabled because the Edit/Write tools enforce a per-session
timestamp check: a file must be read by the **primary agent** before it can be edited. Subagent reads (via `explore`) do
NOT satisfy this check. Therefore `build` must call `read` directly before editing any file.

### Tool-Level Enforcement Architecture

| Tool       | `explore` | `build`                             | All other agents |
|------------|-----------|-------------------------------------|------------------|
| `read`     | ✅ enabled | ✅ enabled (required for Edit/Write) | ❌ disabled       |
| `glob`     | ✅ enabled | ❌ disabled                          | ❌ disabled       |
| `grep`     | ✅ enabled | ❌ disabled                          | ❌ disabled       |
| `webfetch` | ✅ enabled | ❌ disabled                          | ❌ disabled       |

### Build Agent

The `build` agent has `read` enabled. Use it as follows:

- **`read`**: Call directly before editing any file — required to satisfy the Edit/Write timestamp check
- **`glob`, `grep`, `webfetch`**: NEVER use directly — always delegate to `explore` via Task
- Pattern: delegate to `explore` for discovery/search → call `read` directly on the specific file → edit

### All Other Primary Agents

The `plan`, `debug`, `docs`, `code-reviewer`, `architect`, `security-reviewer`, `build-error-resolver`, and `refactor`
agents have `read`, `glob`, `grep`, and `webfetch` **disabled at the tool level**:

- **ALL** file reading, codebase searches, and web fetches **MUST** be delegated to the `explore` subagent via the
  `Task` tool
- `explore` has explicit overrides in its own prompt to ignore delegation rules, preventing infinite recursion

### Edit Tool Usage

The Edit/Write tools enforce a **per-session timestamp check**: the primary agent must have called `read` on a file
after its last modification, or the edit will be rejected with "File has been modified since it was last read."

- **`build` agent**: call `read` directly on the target file immediately before editing
- **All other agents**: cannot edit files — only `build`, `build-error-resolver`, `refactor`, and `docs` have write
  tools enabled

### No Direct File Reading via Bash

Do not use `bash` with `cat`, `head`, `tail`, or similar commands to read file contents — always delegate to `explore`
via `Task`.

---

## Code Execution

### Python Execution Guard

**NEVER** run `python` or `python3` directly. It is blocked at the permission level. Running Python scripts can silently
exfiltrate secrets via network calls, environment variable reads, or file system access — even for seemingly innocent
tasks like JSON validation.

#### Preferred Alternative: jq

For JSON tasks, always prefer `jq`:

```bash
# Validate JSON syntax
jq . file.json

# Validate from stdin
echo '{"key": "val"}' | jq .

# Extract a field
jq '.key' file.json
```

#### Exception: Docker Sandbox

If Python is absolutely required, run it **inline** inside an isolated Docker container — no script file needed:

```bash
# Inline one-liner (preferred)
docker run --rm --network none -i python:3-alpine python -c "<your code here>"

# Multi-line via heredoc stdin
docker run --rm --network none -i python:3-alpine python - <<'EOF'
# your python code here
EOF

# Only if file I/O is needed: mount minimum directory as read-only
docker run --rm --network none -i -v "$(pwd):/work:ro" -w /work python:3-alpine python -c "<your code here>"
```

**Rules for Docker Python:**

- `--rm` — container destroyed after use (clean environment)
- `--network none` — no internet access whatsoever
- `-i` — allows stdin piping for inline code
- Use inline `-c` or heredoc stdin — **never write a `.py` file first**
- If a mount is needed, use `:ro` (read-only) and mount only the minimum directory
- **Never mount** directories containing secrets: `~/.ssh`, `~/.kube`, `~/.config`, `.env` parent dirs

---

## Privacy & Secret Handling

### Mandatory: Load Privacy Guard Skill

**ALWAYS** load the `privacy-guard` skill before:

- Reading any user-provided file
- Outputting or sharing file contents that may contain secrets, credentials, or PII
- Processing `.env`, config, credential, or key files of any kind

This applies even when the task appears unrelated to secrets — user-provided files may contain sensitive data that is
not immediately obvious. Skipping this step is a critical protocol violation.
