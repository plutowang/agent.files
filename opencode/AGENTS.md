<!-- @import _core/1_governance/skills_manifest.md -->

## Agent Orchestration

Delegate only to a subagent your own permissions allow. The `Callable by` column is authoritative — a delegation outside it will be refused.

| Trigger | Subagent | Callable by | When |
| --- | --- | --- | --- |
| Discovery | `explore` | build, design, docs, debug, build-error-resolver | Any file discovery, pattern search, or documentation retrieval |
| Design decision | `architect` | design | Two or more genuinely different approaches are viable |
| Restructuring | `refactor` | build, design | Duplication or complexity is blocking progress |
| Build failure | `build-error-resolver` | build | Two failed attempts → delegate once; if that also fails, BLOCKED ⏸ (III) |
| Security-sensitive | `security-reviewer` | build | Auth, crypto, secrets, or input validation touched |
| Broad change | `code-reviewer` | build | Changes touching more than 3 files, or critical paths (auth, data, API) |
| Claimed complete | `verifier` | build | Skeptical validation before declaring done |
| Docs stale | `docs` | build | After significant implementation |

**User-initiated only:** `debug`.

The phase pipeline: design loads `brainstorming` then `writing-plans`; implementation loads `subagent-driven-dev` then `verification-gate`.

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
