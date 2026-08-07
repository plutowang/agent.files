<!-- @import _core/1_governance/skills_manifest.md -->

## Agent Orchestration

The `build` and `design` agents auto-delegate to specialized subagents:

| Trigger                     | Subagent               | When                                                                          |
| --------------------------- | ---------------------- | ----------------------------------------------------------------------------- |
| Codebase search / Web fetch | `explore`              | Need to find files, search code, or retrieve web documentation                |
| Design decision             | `architect`            | Multiple viable approaches (design phase only)                                |

| Build failure               | `build-error-resolver`  | After 2 failed build/test attempts                                            |
| Security-sensitive code     | `security-reviewer`     | Auth, crypto, secrets, input validation touched                               |
| Code restructuring          | `refactor`             | Duplication or complexity blocking progress                                   |
| Broad code changes          | `code-reviewer`        | Build completed changes touching >3 files or critical paths (auth, data, API)|
| Task claimed completed      | `verifier`             | Skeptical validation of implementations and tests before declaring done       |
| Docs need updating          | `docs`                 | After significant implementation                                              |

**User-initiated only:** `debug` (invoke explicitly when needed)

The integrated Superpowers pipeline flows through design → build agents: brainstorming and writing-plans during design, subagent-driven-dev with TDD during implementation, and verification-gate before completion. Each phase loads the relevant skill automatically — skills are listed in the manifest above.

## Delegation Format

When delegating, provide structured context:

**Parent provides:**

1. What was attempted and the current state
2. The exact error message or output (if applicable)
3. Relevant file paths, line numbers, AND complete file contents required for the task
4. What has already been tried (to avoid re-exploration)

**Subagent returns:**

1. Diagnosis of the issue
2. Actions taken (with file:line references)
3. Remaining issues or follow-ups (if any)

<!-- @import _core/1_governance/hitl_gates.md -->
<!-- @import _core/1_governance/execution_safety.md -->
<!-- @import _core/1_governance/anti_loop.md -->
<!-- @import _core/2_workflows/communication.md -->
