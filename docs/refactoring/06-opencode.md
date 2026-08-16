# Refactoring Phase 5 — OpenCode Shells Audit

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 12 → 13)
**Scheme:** Host shells own the canonical skeleton — `<red_lines>` → `<execution_protocol>` → [`<standards>`] → [`<formatting_and_memory>`] → [`<pre_flight_check>`]; shell-own rules + fragment imports placed inside matching sections; frontmatter byte-identical.

## Scope Applied — 13 shells

| Shell | Structure | Content preserved |
|---|---|---|
| `opencode/agents/debug.md` | red_lines (Constraints + error_triage/redlines) + protocol (7-step loop + error_triage/protocol) + formatting (Retrieval & Tools) | ✅ |
| `opencode/agents/explore.md` | red_lines (9 Rules) + protocol (Identity/Process/Thoroughness/Web) + formatting (Output/Error) | ✅ |
| `opencode/agents/evolver.md` | red_lines (Strict Constraints + CRITICAL SAFEGUARD) + standards (Architecture Context) + protocol (Analytical Focus/Workflow) | ✅ |
| `opencode/agents/design.md` | red_lines (Core Rule + Rules + smell_detection/redlines) + protocol (Process/Retrieval/Delegation + feature_dev_design + smell_detection/protocol) + standards (smell_detection/standards) + formatting (Output Format) | ✅ |
| `opencode/agents/build-error-resolver.md` | red_lines (Do NOT + error_triage/redlines) + protocol (Process/Rules/Loop/Dev + error_triage/protocol) + formatting (Output/Access + edit_accuracy/memory) | ✅ |
| `opencode/agents/docs.md` | red_lines (documentation/redlines) + protocol (documentation/protocol) + formatting (Access + documentation/memory + edit_accuracy/memory) | ✅ |
| `opencode/agents/code-reviewer.md` | red_lines (code_review + code_standards redlines) + protocol (code_review/protocol + subagent note) + standards (code_standards/standards) + formatting (code_review/memory + Security Delegation + Context) | ✅ |
| `opencode/agents/verifier.md` | red_lines (Rules + testing_aaa/redlines) + protocol (Process + testing_aaa/protocol) + standards (testing_aaa/standards) + formatting (Output/Access) + preflight (testing_aaa/preflight) | ✅ |
| `opencode/agents/security-reviewer.md` | red_lines (Do NOT + security_audit/redlines) + protocol (security_audit/protocol) + standards (security_audit/standards) + formatting (Context + security_audit/memory) + preflight (security_audit/preflight) | ✅ |
| `opencode/agents/architect.md` | red_lines (Do NOT + architecture/redlines) + protocol (API Design + architecture/protocol) + standards (architecture/standards) + formatting (architecture/memory) | ✅ |
| `opencode/agents/refactor.md` | red_lines (Do NOT + refactor_persona + smell_detection redlines) + protocol (Context + refactor_persona + smell_detection protocol) + standards (smell_detection + extraction_patterns standards) + formatting (refactor_persona/memory) | ✅ |
| `opencode/rules/agent-constraints.md` | red_lines (No bash reading, Web Access Intent, Code Execution, Privacy Guard) + standards (Capability Model, Read Budget, etc.) | ✅ |
| `opencode/rules/critical-invariants.md` | red_lines (invariants/redlines import) | ✅ |

**Totals:** 11 agents + 2 rules rebuilt; all frontmatter byte-identical (permission blocks preserved); all shell-own content preserved; imports placed in matching sections.

## Verification

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files ✅
3. **Compiled read-back** (`dist/opencode/agents/design.md`): single `<red_lines>` (shell rules + smell_detection/redlines merged) → `<execution_protocol>` → `<standards>` → `<formatting_and_memory>`; one of each tag, no headings ✅
4. Permission alignment: prompt text references only tools/subagents in each shell's YAML (e.g., explore uses glob/grep/read which are allowed; design delegates to explore/architect/refactor which are allowed) ✅

## Notes

- `opencode/agents/build.md` already had a skeleton (Phase 0/0.5) — not re-touched.
- `opencode/commands/*` (8) done in Phase 3; `tokenscope.md` has no imports (plugin command) — no change.
- All 11 remaining opencode agents now have canonical skeletons.

## Next

Gate 8 → Phase 6 (Cursor shells: agents ×7 + rules ×9 — skeleton treatment; commands ×7 done in Phase 3).