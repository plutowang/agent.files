# Agent Constraints

## Capability Model

Two invariants govern every agent:

1. **Discovery and web retrieval belong to `explore` alone.** `glob`, `grep`, and `webfetch` are denied to every other
   agent at the permission level. Delegate all searching, pattern matching, and documentation fetching to `explore`.
2. **Reading is available to agents that edit or plan.** `read` is not a privilege reserved for one agent — it is
   granted wherever a file's exact contents are load-bearing.

| Agent                                                                             | `read` | `edit` scope                                            | Delegates to                      |
| --------------------------------------------------------------------------------- | ------ | ------------------------------------------------------- | --------------------------------- |
| `explore`                                                                         | ✅     | none — read-only                                        | nothing (cannot delegate)         |
| `build`                                                                           | ✅     | anything except `.env*`, `*.key`, `*.pem`, `secrets.*`   | 7 subagents                       |
| `design`                                                                            | ✅ — under the Read Budget below | `docs/**` only                       | `explore`, `architect`, `refactor` |
| `docs`                                                                            | ✅     | `*.md`, `*.txt` only                                    | `explore`                         |
| `build-error-resolver`                                                            | ✅     | anything (prompted)                                     | `explore`                         |
| `evolver`                                                                         | ✅     | none — proposes changes only                            | nothing                           |
| `architect`, `code-reviewer`, `verifier`, `refactor`, `security-reviewer`, `debug` | ❌     | none                                                    | `explore` where permitted         |

### Reading Before Editing

Edit/Write enforce a **per-session timestamp check** — the *primary* agent must have called `read` on a file after its
last modification, or the edit is rejected with "File has been modified since it was last read." Subagent reads do NOT
satisfy this check. Every write-enabled agent must call `read` itself immediately before editing.

### Read Budget

`read` is for files whose contents are load-bearing — ones you will quote, edit, or verify. If you are reading to *find*
something, delegate instead; the test is whether you could name the file before opening it. Pattern: delegate for
discovery → `read` the specific file → edit.

### Agents Without `read`

`architect`, `code-reviewer`, `verifier`, `refactor`, `security-reviewer`, and `debug` work from **parent-provided
context**. The dispatching agent must include complete file contents in the dispatch. If context is missing, report the
gap to the parent — do not guess, and do not attempt a denied tool.

### The Retrieval Agent Is Exempt

These delegation rules bind *callers* of the retrieval agent. The retrieval agent itself is exempt and must use its own
tools directly — it cannot delegate to itself.

### No File Reading via Bash

Never use `bash` with `cat`, `head`, `tail`, or similar to read file contents. Use `read` if you have it; otherwise
delegate to `explore`.

### Web Access Intent

`webfetch` is denied outside `explore`, and the MCP documentation tools are held to the same intent: **no arbitrary
browsing.** Fetch library, API, and CLI documentation — not general web content.

---

## Code Execution

`python` and `python3` are blocked at the permission level — Python can silently exfiltrate secrets through network
calls, environment reads, or file access, even for tasks as innocent as JSON validation.

- **JSON**: use `jq` (`jq . file.json`, `jq '.key' file.json`).
- **Anything else**: if Python is genuinely unavoidable, run it inline in a throwaway network-less sandbox. The exact
  invocation is in the Runtime Safety rules of the global instructions — never write a `.py` file first, and never mount
  a directory that could contain secrets.

---

## Privacy & Secret Handling

### Mandatory: Load Privacy Guard Skill

**ALWAYS** load the `privacy-guard` skill before:

- Reading any user-provided file
- Outputting or sharing file contents that may contain secrets, credentials, or PII
- Processing `.env`, config, credential, or key files of any kind

This applies even when the task appears unrelated to secrets — user-provided files may contain sensitive data that is
not immediately obvious. Skipping this step is a critical protocol violation.
