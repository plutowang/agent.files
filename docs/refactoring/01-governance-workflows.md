# Refactoring Phase 1 — Governance + Workflows Audit Report

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 4)
**Staging source:** `docs/refactoring/01-governance-workflows-staged.md` (applied verbatim)

## Scope Applied

- **Phase 1 (11 files):** `_core/1_governance/` (invariants, execution_safety, hitl_gates, edit_accuracy, skills_manifest) + `_core/2_workflows/` (feature_dev_build, feature_dev_design, documentation, error_triage, communication, gitlab_context)
- **Phase 0.5 (4 files):** `_core/5_commands/review.md` (imports into sections + IDE-neutral), `opencode/commands/review.md` (+`security-reviewer` line), `opencode/agents/build.md` (4 import moves), `cursor/rules/agent-core.mdc` (1 import move)

## Line Metrics (before → after; budgets: <200 agent/global, <500 skill/.mdc)

| File | Lines before | Lines after | Budget status |
|---|---|---|---|
| invariants.md | 14 | 16 | ✅ 16/200 |
| execution_safety.md | 16 | 18 | ✅ 18/200 |
| hitl_gates.md | 24 | 19 | ✅ 19/200 |
| edit_accuracy.md | 10 | 9 | ✅ 9/200 |
| skills_manifest.md | 31 | 33 | ✅ 33/200 |
| feature_dev_build.md | 35 | 40 | ✅ 40/200 |
| feature_dev_design.md | 17 | 19 | ✅ 19/200 |
| documentation.md | 28 | 27 | ✅ 27/200 |
| error_triage.md | 50 | 38 | ✅ 38/200 |
| communication.md | 35 | 36 | ✅ 36/200 |
| gitlab_context.md | 79 | 64 | ✅ 64/200 |
| `_core/5_commands/review.md` | 79 | 89 | ✅ 89/200 |
| `opencode/commands/review.md` | 11 | 12 | ✅ 12/200 |
| `opencode/agents/build.md` | 89 | 93 | ✅ 93/200 |
| `cursor/rules/agent-core.mdc` | 40 | 40 | ✅ 40/500 |

## Constraint Parity (from staging kit, applied verbatim)

| File | Constraints IN | Constraints OUT | Status |
|---|---|---|---|
| invariants.md | 7 | 7 | ✅ |
| execution_safety.md | 6 | 6 | ✅ |
| hitl_gates.md | 9 | 9 | ✅ |
| edit_accuracy.md | 5 | 5 | ✅ |
| skills_manifest.md | 26 | 26 | ✅ |
| feature_dev_build.md | 16 | 16 | ✅ |
| feature_dev_design.md | 10 | 10 | ✅ |
| documentation.md | 17 | 17 | ✅ |
| error_triage.md | 24 | 24 | ✅ |
| communication.md | 19 | 19 | ✅ |
| gitlab_context.md | 12 | 12 | ✅ |
| **Phase 1 total** | **151** | **151** | **✅ 100%** |
| review.md (0.5) | 10 | 10 | ✅ |
| opencode command (0.5) | 1 added (IDE name) | 1 | ✅ |
| build.md (0.5) | 24 | 24 | ✅ |
| agent-core.mdc (0.5) | 8 | 8 | ✅ |

## Contract Verification (compiled output read-back, 2026-08-12)

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files ✅
3. **Imports nest inside parent XML sections** (verified by read):
   - `dist/opencode/agents/build.md` — `feature_dev_build` content (own nested `<red_lines>`/`<execution_protocol>`/`<pre_flight_check>`) inside parent `<execution_protocol>` (lines 71–112); `<standards>` section follows (line 114); `edit_accuracy` inside `<formatting_and_memory>` ✅
   - `dist/cursor/rules/agent-core.mdc` — `execution_safety` content nested inside parent `<red_lines>` (lines 16–30) ✅
   - `dist/opencode/commands/review.md` — `gitlab_context` inside `<execution_protocol>` (line 92); `code_review`+`code_standards` inside `<standards>` (closes line 276); `<pre_flight_check>` last (278–280) ✅
   - `dist/cursor/agents/code-reviewer.md` — same nesting; neutral delegation line (line 88) ✅
4. **Cross-IDE contamination fixed:** cursor compiled agent contains "dedicated security review agent" (neutral) — no `security-reviewer`; its shell tail supplies `/security-auditor`. opencode compiled command ends with `security-reviewer` delegation (line 282) ✅
5. **Lexical Ban:** no banned words introduced in `_core/` files ✅
6. **Frontmatter:** all byte-identical (build.md permission block, opencode command description, agent-core.mdc description/alwaysApply) ✅

## Notes

- `gitlab_context.md` line count dropped 79→64 via prose compression (steps condensed to bold headers) — all 8 steps + detection + fallback preserved verbatim in content.
- `error_triage.md` 50→38: rationalization table compressed to one bullet with all 5 excuses + realities.
- `_core/5_commands/review.md` grew 79→89 (XML tags + pre-flight + imports moved inside sections) — structural cost, within budget.
- Phase 0 pilot files remain as applied; `docs/refactoring/00-pilot.md` matrices still valid (content unchanged by 0.5 except import placement + one neutralized name, documented in Appendix A of the staging kit).

## Next

Gate 3 → Phase 2 (Engineering + Refactoring, 9 files) with the same content-driven analysis per file.