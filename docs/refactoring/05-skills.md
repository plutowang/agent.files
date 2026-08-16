# Refactoring Phase 4 — Skills Audit

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 11 → 12)
**Scheme:** Skills keep their own pyramid (standalone artifacts, shipped verbatim to `dist/*/skills/` — not imported). Each SKILL.md: own XML sections (`<red_lines>` → `<execution_protocol>` → [`<standards>`] → [`<formatting_and_memory>`] → [`<pre_flight_check>`]), bold labels instead of markdown headings, frontmatter byte-identical (name/description/license), description ≤1024 chars, body <500 lines.

## Scope Applied — 24 skills

| Skill | Lines before → after | Structure | Content preserved |
|---|---|---|---|
| rest-api | 394 → 366 | red_lines + standards + pre_flight_check | ✅ (2 dropped examples caught + restored during writing) |
| graphql | 442 → 445 | red_lines + standards | ✅ (first draft had 4 losses — caught + fully rewritten) |
| writing-for-agents | 63 → 63 | red_lines + standards | ✅ |
| diagnosing-bugs | 89 → 89 | red_lines + protocol + pre_flight_check | ✅ |
| receiving-code-review | 126 → 117 | red_lines + protocol + formatting | ✅ |
| git | 100 → 100 | red_lines + standards + protocol | ✅ |
| zig | 100 → 100 | red_lines + protocol + standards | ✅ |
| brainstorming | 40 → 40 | red_lines + protocol + standards | ✅ |
| subagent-driven-dev | 77 → 77 | red_lines + protocol + formatting | ✅ |
| aws | 75 → 75 | red_lines + standards + protocol | ✅ |
| writing-plans | 72 → 72 | red_lines + protocol | ✅ |
| verification-gate | 61 → 61 | red_lines + protocol + formatting | ✅ |
| domain-modeling | 70 → 70 | standards + protocol | ✅ |
| test-driven-development | 45 → 45 | red_lines + protocol + standards | ✅ |
| angular | 41 → 41 | red_lines + standards | ✅ |
| csharp | 56 → 56 | red_lines + protocol + standards | ✅ |
| privacy-guard | 42 → 42 | red_lines + protocol | ✅ |
| react | 34 → 34 | red_lines + standards | ✅ |
| research | 32 → 32 | red_lines + protocol | ✅ |
| workflow-env | 31 → 31 | red_lines + protocol | ✅ |
| go | 24 → 24 | red_lines + standards + protocol | ✅ |
| rust | 24 → 24 | red_lines + standards + protocol | ✅ |
| nx-monorepo | 42 → 42 | protocol + standards | ✅ |
| git-worktrees | 77 → 77 | red_lines + protocol | ✅ |

**Totals:** 24 skills, all ≤500 lines (max 445), all descriptions ≤1024 chars, no XML in frontmatter, all content preserved (2 zero-loss violations caught and corrected during writing — rest-api idempotency/validation examples, graphql schema-evolution content).

## Verification

1. `zig build test` → EXIT 0 ✅
2. `./agentc-cli build` → SUCCESS, 104 files (26 skills copied to dist) ✅
3. Skills ship verbatim — no import machinery involved ✅
4. Frontmatter byte-identical (name/description/license preserved) ✅

## Notes

- **Zero-loss discipline:** two skills required corrective rewrites during the phase (rest-api: 2 dropped example blocks; graphql: schema-evolution section mangled + 2 dropped code blocks). Both restored to full parity — evidence that the per-skill audit loop works.
- **Section placement is content-driven:** reference-heavy skills (rest-api, graphql, writing-for-agents) use red_lines + standards; workflow skills (diagnosing-bugs, subagent-driven-dev, verification-gate) use red_lines + protocol + preflight/formatting; no section is force-added where content doesn't justify it.
- **All 25 skills now compliant** (code-review was done in Phase 0).

## Next

Gate 7 → Phase 5 (OpenCode shells: agents ×11 + rules ×2 — skeleton treatment; commands ×8 done in Phase 3).