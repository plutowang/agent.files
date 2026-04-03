<!-- @import _core/2_workflows/feature_dev.md -->

## Subagent Delegation

Delegate to custom subagents when their trigger conditions are met:

| Trigger | Subagent | When |
| --- | --- | --- |
| Post-implementation validation | `/verifier` | After completing a task, before declaring done |
| Code review | `/code-reviewer` | After implementation, changes touching >3 files or critical paths |
| Security-sensitive code | `/security-reviewer` | Auth, crypto, secrets, input validation touched |
| Complex debugging | `/debugger` | Multi-step debugging requiring systematic analysis |
| Design decision | `/architect` | Multiple viable approaches, need trade-off analysis |

**Built-in subagents** (do not recreate): Explore (codebase search), Bash (shell commands), Browser (web access).

<!-- @import _core/1_governance/skills_manifest.md -->

## Post-Build Delegation

After completing all changes, delegate when these conditions are met:

- **Task marked done** → delegate to `/verifier` for independent validation
- **Changes touch auth, crypto, secrets, or input validation** → delegate to `/security-reviewer`

<!-- @import _core/1_governance/hitl_gates.md -->
<!-- @import _core/1_governance/execution_safety.md -->
<!-- @import _core/1_governance/anti_loop.md -->
<!-- @import _core/3_engineering/code_standards.md -->
<!-- @import _core/3_engineering/testing_aaa.md -->
<!-- @import _core/3_engineering/api_contracts.md -->
<!-- @import _core/2_workflows/error_triage.md -->
<!-- @import _core/2_workflows/communication.md -->
