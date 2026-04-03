<!-- @import _core/2_workflows/feature_dev.md -->

<!-- @import _core/1_governance/skills_manifest.md -->

## Agent Orchestration

The `build` and `plan` agents auto-delegate to specialized subagents via the Task tool:

| Trigger                     | Subagent               | When                                                                          |
| --------------------------- | ---------------------- | ----------------------------------------------------------------------------- |
| Codebase search / Web fetch | `explore`              | Need to find files, search code, or retrieve web documentation                |
| Design decision             | `architect`            | Multiple viable approaches (plan agent only)                                 |
| Build failure               | `build-error-resolver`  | After 2 failed build/test attempts                                            |
| Security-sensitive code     | `security-reviewer`     | Auth, crypto, secrets, input validation touched                               |
| Code restructuring          | `refactor`             | Duplication or complexity blocking progress                                   |
| Broad code changes          | `code-reviewer`        | Build completed changes touching >3 files or critical paths (auth, data, API)|
| Docs need updating          | `docs`                 | After significant implementation                                              |

**User-initiated only:** `debug` (expensive pro model — invoke explicitly when needed)

## Delegation Format

When delegating to a subagent via Task, always provide structured context:

**Parent provides:**

1. What was attempted and the current state
2. The exact error message or output (if applicable)
3. Relevant file paths and line numbers
4. What has already been tried (to avoid re-exploration)

**Subagent returns:**

1. Diagnosis of the issue
2. Actions taken (with file:line references)
3. Remaining issues or follow-ups (if any)

<!-- @import _core/1_governance/hitl_gates.md -->
<!-- @import _core/1_governance/execution_safety.md -->
<!-- @import _core/1_governance/anti_loop.md -->
<!-- @import _core/2_workflows/error_triage.md -->
<!-- @import _core/2_workflows/communication.md -->
