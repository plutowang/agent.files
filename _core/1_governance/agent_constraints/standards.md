**Capability Model**

Two invariants govern every agent:

1. **Discovery and web retrieval belong to the retrieval agent alone.** Search, pattern matching, and web fetching are denied to most agents at the permission level — the debugging agent may search directly (its permission block allows it) but prefers delegating discovery to the retrieval agent; every other agent delegates all searching and documentation fetching to the retrieval agent.
2. **Reading is available to agents that edit or plan.** Reading is not a privilege reserved for one agent — it is granted wherever a file's exact contents are load-bearing.

| Agent | read | edit scope | Delegates to |
| --- | --- | --- | --- |
| Retrieval agent | ✅ | none — read-only | nothing (cannot delegate) |
| Implementation agent | ✅ | anything except `.env*`, `*.key`, `*.pem`, `secrets.*` | 7 subagents |
| Planning agent | ✅ — under the Read Budget below | docs only | retrieval, architect, refactoring agents |
| Documentation agent | ✅ | `*.md`, `*.txt` only | retrieval agent |
| Build-error agent | ✅ | anything (prompted) | retrieval agent |
| Debugging agent | ✅ | prompted edits only (user-invoked) | retrieval agent |
| Evolution agent (disabled — kept for future re-arm) | ✅ | none — proposes changes only | nothing |
| Architect, code review, verifier, refactoring, security review agents | ❌ | none | retrieval agent where permitted |

**Reading Before Editing**

Edits enforce a **per-session freshness check** — the *primary* agent must have read a file after its last modification, or the edit is rejected. Subagent reads do NOT satisfy this check. Every write-enabled agent must read the file itself immediately before editing.

**Read Budget**

Reading is for files whose contents are load-bearing — ones you will quote, edit, or verify. If you are reading to *find* something, delegate instead; the test is whether you could name the file before opening it. Pattern: delegate for discovery → read the specific file → edit.

**Agents Without Read Access**

The architect, code-review, verifier, refactoring, and security review agents work from **parent-provided context**. The dispatching agent must include complete file contents in the dispatch. If context is missing, report the gap to the parent — do not guess, and do not attempt a denied tool.

**The Retrieval Agent Is Exempt**

These delegation rules bind *callers* of the retrieval agent. The retrieval agent itself is exempt and must use its own tools directly — it cannot delegate to itself.
