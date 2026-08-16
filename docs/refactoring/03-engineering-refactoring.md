# Refactoring Phase 2 — Engineering + Refactoring Audit

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 8 → 9)
**Scheme:** rev. 4 fragments — concept folders, tag-free, heading-free (bold labels)

## Scope Applied

**9 concepts → 26 fragments:**

| Concept | Fragments | Content blocks preserved |
|---|---|---|
| `_core/3_engineering/testing_aaa/` | standards, redlines, protocol, preflight | 15/15 ✅ |
| `_core/3_engineering/code_standards/` | standards, redlines | 9/9 ✅ |
| `_core/3_engineering/code_review/` | protocol, redlines, memory | 6/6 ✅ |
| `_core/3_engineering/security_audit/` | redlines, standards, protocol, preflight, memory | 10/10 ✅ |
| `_core/3_engineering/architecture/` | protocol, standards, redlines, memory | 8/8 ✅ |
| `_core/3_engineering/api_contracts/` | standards | 7/7 ✅ |
| `_core/4_refactoring/smell_detection/` | redlines, standards, protocol | 4/4 ✅ |
| `_core/4_refactoring/extraction_patterns/` | standards | 7/7 ✅ |
| `_core/4_refactoring/refactor_persona/` | protocol, redlines, memory | 3/3 ✅ |
| **Total** | **26 fragments** | **69/69 ✅** |

**Content-driven splits:** TDD Iron Law/Red Flags/Rationalizations → redlines; RED-GREEN-REFACTOR/When Stuck → protocol; Philosophy/Coverage → standards; Checklist → preflight. No Shortcuts → redlines. Do NOT → redlines; Process/Axes/Smells → protocol; Severity/Output → memory. Security Rules → redlines; Standards → standards; Process → protocol; Checklist → preflight; Output → memory. Architecture Anti-Patterns + Design Rules → redlines; Methodology → protocol; Heuristics/Catalog/ATAM/Deep Modules → standards; Templates → memory. Refactor Principles + Extraction Discipline → redlines; Catalog → standards; When → protocol.

## Importers Updated (27 files)

- **Skeleton shells (3):** `opencode/agents/build.md` (testing_aaa + code_standards fragments into matching sections), `opencode/commands/review.md` + `cursor/agents/code-reviewer.md` (code_review → protocol/redlines/memory sections; code_standards → standards/redlines)
- **Plain shells (10):** opencode agents code-reviewer, verifier, security-reviewer, architect, refactor, design; cursor agents verifier, security-auditor, architect, refactor
- **Cursor rules (6):** testing, code-standards, security, architecture, refactoring, api-design
- **5_commands (5):** explain, fix, test, security, refactor (full fragment sets)
- **Examples (3):** copilot example_agent.agent, copilot example_AGENTS, cursor example_subagent
- **Prose refs (2):** `ARCHITECTURE.md:58`, `.opencode/commands/agentfile-audit.md:16` (edit_accuracy.md → edit_accuracy/memory.md)

## Verification

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files ✅
3. **Dist re-audit (46 files, explore):** 29 PASS immediately; 10 FAILs cleared by `## Process` → `**Process**` fix in 5 command files (verified: `dist/opencode/commands/test.md:9` now `**Process**`); **XML tags 100% clean** — exactly one of each tag per skeleton shell, no nesting/duplication ✅
4. **Remaining 7 flagged lines are code-fenced templates** (intentional, documented): `# ADR-XXX`/`## Status` etc. inside ```markdown fence in `architecture/memory.md`; `## Refactor Plan: {Title}` in `refactor_persona/memory.md`; `## Requirements (from GitLab)` in `gitlab_context/protocol.md`. These are literal output examples the agent emits — inside code fences they do NOT render as headings and do not pollute structure. Converting them to bold would change the emitted template format (behavior change) — kept verbatim per zero-loss.
5. **build.md `<standards>` section verified clean:** only bold labels (`**Philosophy**`, `**Type Safety**`, …), no `##` headings ✅

## Notes

- Shell-own headings (`## Process`, `## Rules`, `## Do NOT`, `## Context & File Access` in agent bodies) are legitimate — they are the shell's own structure, not fragment-injected (verified against source shells).
- Phase 3 (commands) will convert the 5 command files to concept folders; their `**Process**` labels already comply with the fragment scheme.
- Suggested future CI check (from audit): reject `^#{1,4}` lines in `_core/**` outside `_core/skills/` and outside code fences.

## Next

Gate 5 → Phase 3 (Commands: commit, fix, security, explain, refactor, test → concept folders + opencode/cursor command shells skeleton treatment).