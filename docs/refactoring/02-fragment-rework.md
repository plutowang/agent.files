# Refactoring Phase 2 — Rev. 4 Fragment Rework Audit

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` §1b (rev. 6)
**Staging source:** `docs/refactoring/02-fragment-rework-staged.md` (applied verbatim)
**Design:** Option 3 — concept folders; XML tags live ONLY in host shells; fragments carry no XML and no markdown headings.

## What Changed

1. **25 fragment files created** across 13 concept folders (`_core/1_governance/`, `_core/2_workflows/`, `_core/5_commands/`) — content split by section type (redlines/protocol/memory/preflight), tag-free, heading-free (bold labels).
2. **6 shells rebuilt** with canonical skeletons: `opencode/agents/build.md`, `cursor/rules/agent-core.mdc`, `opencode/commands/review.md`, `cursor/agents/code-reviewer.md`, `opencode/AGENTS.md` (pulled forward), 3 example files.
3. **13 flat files deleted** (superseded by folders).
4. **11 live stale imports repointed** (build-breakers): critical-invariants ×2, build-error-resolver, docs (opencode agent + cursor agent + cursor rule), debug/debugger, design.
5. **7 stale `.examples`/README references fixed** (5 examples + 2 READMEs).
6. **5 stale prose references fixed** in `.agents/skills/` (agent-architect ×2, agent-ingestor, aupc-auditor ×2).

## Constraint Parity (from staging kit, applied verbatim)

| Concept | Constraints IN | Fragments | Constraints OUT | Status |
|---|---|---|---|---|
| anti_loop | 21 | redlines(5) + protocol(8) + memory(7) + preflight(1) | 21 | ✅ |
| invariants | 7 | redlines(7) | 7 | ✅ |
| execution_safety | 6 | redlines(6) | 6 | ✅ |
| hitl_gates | 9 | redlines(2) + protocol(3) + memory(4) | 9 | ✅ |
| edit_accuracy | 5 | memory(5) | 5 | ✅ |
| skills_manifest | 26 | memory(26) | 26 | ✅ |
| feature_dev_build | 16 | redlines(2) + protocol(8) + preflight(6) | 16 | ✅ |
| feature_dev_design | 10 | protocol(10) | 10 | ✅ |
| documentation | 17 | redlines(7) + protocol(5) + memory(5) | 17 | ✅ |
| error_triage | 24 | redlines(4) + protocol(20) | 24 | ✅ |
| communication | 19 | memory(19) | 19 | ✅ |
| gitlab_context | 12 | protocol(12) | 12 | ✅ |
| review (command) | 10 | redlines(1) + protocol(8) + preflight(1) | 10 | ✅ |
| **Total** | **182** | **25 fragments** | **182** | **✅ 100%** |

## Contract Verification (compiled output read-back, 2026-08-12)

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files ✅
3. **Exactly ONE of each XML tag per compiled shell** (verified by read):
   - `dist/opencode/agents/build.md` — single `<red_lines>` (shell + feature_dev_build/redlines merged), single `<execution_protocol>` (shell + feature_dev_build/protocol merged), `<standards>`, `<formatting_and_memory>`, `<pre_flight_check>` — no nesting, no duplicates ✅
   - `dist/opencode/AGENTS.md` — single `<red_lines>` (hitl_gates + execution_safety + anti_loop redlines merged), single `<execution_protocol>`, single `<formatting_and_memory>` (skills_manifest + hitl_gates + anti_loop + communication memory merged), single `<pre_flight_check>` ✅
   - `dist/opencode/commands/review.md` — skeleton with review fragments; gitlab_context inlined via fragment-level import inside `<execution_protocol>` ✅
   - `dist/cursor/rules/agent-core.mdc` — execution_safety fragment content merged into single `<red_lines>` (lines 16–29), no nested tags ✅
4. **Zero fragment markdown headings** in compiled output (fragments use bold labels) ✅
5. **No cross-IDE contamination** — cursor code-reviewer keeps neutral "dedicated security review agent" + `/security-auditor` shell tail ✅
6. **Lexical Ban** — no banned words introduced in `_core/` fragments ✅
7. **Frontmatter** — all byte-identical (build.md permission block, agent-core.mdc, review commands, cursor agents) ✅

## Notes & Flags

1. **`<standards>` content still has markdown headings** (`## Testing Standards`, `### Philosophy` from testing_aaa.md) — expected: testing_aaa/code_standards/code_review are Phase 2 files, not yet converted to fragments. Their headings will be removed at Phase 2.
2. **AGENTS.md structural change (flagged):** skills manifest moved from top-of-file into `<formatting_and_memory>` (pyramid position 2); orchestration/delegation content remains as shell preamble above the XML sections.
3. **Unrefactored shells (debug, design, docs, build-error-resolver, etc.)** now import fragments as plain appended content — they receive the skeleton treatment in Phases 5–6.
4. **`copilot/.examples`** files updated for consistency (copilot tree itself remains out of scope).
5. **`opencode/opencode.json`** pre-existing staged MCP bump — untouched.

## Next

Gate 4 → Phase 2 (Engineering + Refactoring, 9 files) with the fragment scheme: `architecture`, `testing_aaa`, `security_audit`, `code_standards`, `code_review`, `api_contracts`, `smell_detection`, `extraction_patterns`, `refactor_persona` → concept folders; update importers (build.md, review shells, verifier, security-reviewer, architect, refactor, code-reviewer, rules/*.mdc).