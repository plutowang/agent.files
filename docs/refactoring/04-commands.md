# Refactoring Phase 3 — Commands Audit

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 9 → 11)
**Scheme:** rev. 4 fragments — concept folders, tag-free, heading-free fragments; shells own skeletons.

## Scope Applied

**6 command bodies → 6 concept folders (8 fragments):**

| Concept | Fragments | Content preserved |
|---|---|---|
| `_core/5_commands/commit/` | redlines, protocol, memory | 16/16 lines ✅ (read-only rule + no add/commit/push + no-deliberate + steps + output format) |
| `_core/5_commands/explain/` | protocol | 5 steps ✅ |
| `_core/5_commands/fix/` | protocol | 6 steps ✅ (incl. ⏸ (I) gate, failing-test-first, verify) |
| `_core/5_commands/test/` | protocol | 5 steps ✅ (incl. ⏸ (I) test-plan gate) |
| `_core/5_commands/security/` | protocol | 6 steps ✅ (incl. ⏸ (I) report gate) |
| `_core/5_commands/refactor/` | protocol | 5 steps ✅ (incl. ⏸ (I) plan gate) |

**12 command shells rebuilt with skeletons** (opencode ×6, cursor ×6):
- Frontmatter byte-identical (opencode commit keeps `name`/`model`; cursor shells keep cursor-style `name`/`description`)
- IDE glue preamble preserved (opencode `@$1`/`$ARGUMENTS`; cursor "currently active editor tab")
- Cross-section engineering imports hoisted into matching sections:
  - explain/fix → `code_standards/redlines.md` (red_lines) + `code_standards/standards.md` (standards)
  - test → `testing_aaa` redlines/protocol/standards/preflight (4 sections)
  - security → `security_audit` redlines/protocol/standards/memory/preflight (5 sections)
  - refactor → `smell_detection` redlines/protocol/standards + `extraction_patterns/standards.md`
- `cursor/commands/review.md` unchanged — pure delegation shell (→ `/code-reviewer`), no `_core` import

**6 old flat command files deleted** (`_core/5_commands/{commit,explain,fix,test,security,refactor}.md`).

## Verification

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files ✅
3. **Compiled read-back** (`dist/opencode/commands/fix.md`): exact skeleton — `<red_lines>` (No Shortcuts) → `<execution_protocol>` (**Process** + 6 steps incl. gates) → `<standards>` (Type Safety…); single of each tag, zero headings ✅
4. Content parity: all command steps verbatim (2 wording deviations caught and restored during writing)

## Notes

- All 5_commands concepts now comply with the fragment scheme → remaining fragment work is Phase 4 (skills, standalone pyramids).
- `_core/5_commands/` now contains only concept folders: `commit/`, `explain/`, `fix/`, `refactor/`, `review/`, `security/`, `test/`.

## Next

Gate 6 → Phase 4 (Skills, 24 remaining — keep own pyramid, standalone).