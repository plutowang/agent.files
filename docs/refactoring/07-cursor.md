# Refactoring Phase 6 — Cursor Shells Audit (FINAL PHASE)

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 13 → 14)
**Scheme:** Host shells own the canonical skeleton; cursor hygiene preserved (`alwaysApply: false` + globs, `/`-syntax interlocks, no OpenCode mechanics); frontmatter byte-identical.

## Scope Applied — 14 shells

**Cursor agents (6):**

| Shell | Structure | Content preserved |
|---|---|---|
| `cursor/agents/debugger.md` | red_lines (Rules + error_triage/redlines) + protocol (Escalation Chain + Tool Usage + error_triage/protocol) | ✅ |
| `cursor/agents/docs.md` | red_lines (documentation/redlines) + protocol (documentation/protocol) + formatting (documentation/memory) | ✅ |
| `cursor/agents/verifier.md` | red_lines (Rules + testing_aaa/redlines) + protocol (AAA + testing_aaa/protocol) + standards (testing_aaa/standards) + preflight (testing_aaa/preflight) | ✅ |
| `cursor/agents/security-auditor.md` | red_lines (Rules + security_audit/redlines) + protocol (Process + security_audit/protocol) + standards + formatting + preflight | ✅ |
| `cursor/agents/architect.md` | red_lines (Critical Rules + architecture/redlines) + protocol (6-step + architecture/protocol) + standards + formatting | ✅ |
| `cursor/agents/refactor.md` | red_lines (refactor_persona + smell_detection redlines) + protocol (both protocols) + standards (smell_detection + extraction_patterns) + formatting (refactor_persona/memory) | ✅ |

**Cursor rules (8):**

| Rule | Structure | Content preserved |
|---|---|---|
| `cursor/rules/testing.mdc` | red_lines (testing_aaa/redlines) + protocol (shell bullets + Interlock + testing_aaa/protocol) + standards (testing_aaa/standards) + preflight (testing_aaa/preflight) | ✅ |
| `cursor/rules/code-standards.mdc` | red_lines (No TODO/debug + code_standards/redlines) + protocol (2 Interlocks) + standards (shell bullets + code_standards/standards) | ✅ |
| `cursor/rules/security.mdc` | red_lines (security_audit/redlines) + protocol (Interlock + security_audit/protocol) + standards + formatting + preflight | ✅ |
| `cursor/rules/architecture.mdc` | red_lines (architecture/redlines) + protocol (Interlock + architecture/protocol) + standards (shell bullets + architecture/standards) + formatting (architecture/memory) | ✅ |
| `cursor/rules/refactoring.mdc` | red_lines (shell bullets + smell_detection/redlines) + protocol (Interlock + smell_detection/protocol) + standards (smell_detection + extraction_patterns) | ✅ |
| `cursor/rules/api-design.mdc` | protocol (Interlock) + standards (shell bullets + api_contracts/standards) | ✅ |
| `cursor/rules/docs.mdc` | red_lines (documentation/redlines) + protocol (documentation/protocol) + formatting (documentation/memory) | ✅ |
| `cursor/rules/critical-invariants.mdc` | red_lines (invariants/redlines) | ✅ |

**Already done:** `cursor/agents/code-reviewer.md` (skeleton, Phase 0.5/2), `cursor/rules/agent-core.mdc` (skeleton, Phase 0.5), `cursor/commands/*` (7, Phase 3; review = delegation shell).

## Verification

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files ✅
3. **Compiled read-back** (`dist/cursor/rules/testing.mdc`): frontmatter + title + single `<red_lines>` (testing_aaa/redlines merged) → `<execution_protocol>` → `<standards>` → `<pre_flight_check>`; one of each tag, no fragment headings ✅
4. Cursor hygiene: `alwaysApply: false` + globs preserved; `/`-syntax interlocks preserved (`/verifier`, `/code-reviewer`, `/debugger`, `/security-auditor`, `/architect`, `/refactor`); no OpenCode-specific mechanics introduced ✅
5. Frontmatter byte-identical (name/description/model/readonly/is_background; .mdc description/globs/alwaysApply) ✅

## Project Completion Summary (all phases)

| Phase | Scope | Status |
|---|---|---|
| 0/0.5/1 | Pilot + governance/workflows → fragments | ✅ |
| 2 | Engineering + refactoring → 26 fragments | ✅ |
| 3 | Commands → 7 concept folders + 12 command shells | ✅ |
| 4 | 24 skills → own pyramid | ✅ |
| 5 | 11 opencode agents + 2 rules → skeletons | ✅ |
| 6 | 6 cursor agents + 8 cursor rules → skeletons | ✅ |

**Final state:** 28 concept folders / 59 fragments in `_core/`; all host shells (opencode + cursor) own canonical skeletons; all 25 skills compliant; imports resolve; XML integrity verified; zero-loss parity maintained per phase (251/251 + command/skill content).

**Remaining user actions:** `./agentc-cli build` (done) + `./agentc-cli link <ide>` to symlink the compiled output.