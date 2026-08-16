# Redundancy Fixes — APPLIED (2026-08-12)

**Date:** 2026-08-12
**Status:** **APPLIED + VERIFIED** — all 9 fixes landed; independent re-audit of compiled dist: 9/9 PASS (one leftover duplicate in review.md caught by the re-audit and removed). `zig build test` EXIT 0; `./agentc-cli build` SUCCESS 104 files.

## Follow-up: Security command single-source-of-truth fix (2026-08-12)

**Evaluation finding:** removing `security_audit/protocol.md` from the security command fixed the within-file duplication but kept the command's own *condensed copy* of the process (losing detail: privilege escalation, language-specific risks, token handling, privilege enforcement, exposed endpoints, insecure defaults) and left source-level duplication (two process files that can drift).

**Fix applied (user-approved):**
1. `_core/3_engineering/security_audit/protocol.md` — step 6 (Report) now carries the ⏸ (I) gate: "Present findings and wait for explicit approval before proceeding." (the command's unique content merged into the standard)
2. `_core/5_commands/security/protocol.md` — DELETED (condensed copy removed; folder removed)
3. `opencode/commands/security.md` + `cursor/commands/security.md` — now import `_core/3_engineering/security_audit/protocol.md` (the single source)

**Result:** one process source, two consumers (security command + security-reviewer/security-auditor agents); all standard detail restored in the command context; gate preserved. Verified in dist read-back (`dist/opencode/commands/security.md` lines 25–34).

**Note:** the ⏸ (I) gate in the standard also applies to the security-reviewer subagent — semantically it reads as "present findings" (the subagent's report) with the parent gating; no stalling risk (subagent returns after reporting).

## A. Within-file content duplication (4 fixes)

**A1. `cursor/agents/verifier.md`** — remove the shell's own `**Rules**` block (4 bullets: read-only / run-tests-not-fix / thorough-concise / report-exact-error). It is byte-identical to the imported `**Verifier Rules**` block in `_core/3_engineering/testing_aaa/redlines.md`. Result: `<red_lines>` contains only the import.

**A2. `cursor/rules/code-standards.mdc`** — remove shell condensed bullets that restate imports:
- In `<red_lines>`: the bullet "No `TODO` without a linked issue. No debug statements. No magic numbers. No commented-out code." duplicates the imported `**No Shortcuts**` block.
- In `<standards>`: the 4 shell bullets (strictest type system / never suppress errors / validate inputs / names describe what) duplicate the imported `**Type Safety**`/`**Error Handling**`/`**Defensive Coding**`/`**Naming & Clarity**` blocks.
Result: `<red_lines>` and `<standards>` contain only imports.

**A3. `cursor/agents/security-auditor.md`** — trim shell `**Auditor Rules**` from 4 bullets to the 2 unique ones (read-only + rate-by-severity + flag-if-uncertain are covered by the imported `**Rules**`/`**Do NOT**`):
- Keep: "Always check for secrets in diff output before approving changes." and "Critical and High findings must be fixed before merge."
- Remove: "You are read-only. Do NOT edit files — only analyze and report." and "If uncertain about a pattern, flag it as a finding rather than ignoring it."

**A4. `cursor/agents/debugger.md`** — remove the shell rule "If stuck after 2 attempts, report findings and ask for guidance." (duplicates the imported error_triage hard threshold: "after 2 independent fix attempts… escalate"). Keep the other 3 shell rules (failing test first, root cause, no unrelated refactor — unique).

## B. Format redundancy (2 fixes)

**B1. `opencode/commands/review.md`** — move the trailing glue line `When security concerns are found during review, delegate to the `security-reviewer` subagent.` from AFTER `</pre_flight_check>` to INSIDE `<execution_protocol>` (after the imports) — it is IDE-specific delegation glue (opencode name supply) and belongs in the protocol section, not orphaned at the file tail.

**B2. `cursor/agents/code-reviewer.md`** — convert the orphaned tail headings `## Security Delegation` and `## Subagent Reporting` (after `</pre_flight_check>`) to bold labels `**Security Delegation**` / `**Subagent Reporting**` — they are cursor-specific glue (references `/security-auditor`) and must not look like orphaned markdown structure.

## D. New-concept correctness (3 fixes)

**D1. `_core/2_workflows/evolver/protocol.md`** — convert the markdown heading `## Session: `[Insert Session ID]`` to bold label `**Session: `[Insert Session ID]**` (fragments must be heading-free).

**D2. `_core/1_governance/orchestration/standards.md`** — neutralize opencode-specific agent names in the delegation table to role names:
- `build-error-resolver` → `build-error agent`
- `Callable by` column: `build` → `implementation agent`, `design` → `planning agent`, `docs` → `documentation agent`, `debug` → `debugging agent`, `build-error-resolver` → `build-error agent`
- `User-initiated only: the debugging agent` — already neutral ✓

**D3. `_core/1_governance/agent_constraints/standards.md`** — neutralize opencode-specific names in the capability table:
- `Evolver` → `Evolution agent`
- `Build-error agent` → keep (already role-based)
- `code review` → `code review agent` (consistent role naming)
- `Retrieval agent` / `Implementation agent` / `Design agent` / `Documentation agent` — already neutral ✓

## Verification (after application)

1. `zig build test` → EXIT 0
2. `./agentc-cli build` → SUCCESS
3. dist re-audit: no within-file duplicated blocks; no orphaned content after `</pre_flight_check>`; evolver fragment heading-free; orchestration/agent_constraints role-neutral
4. Zero-loss: only duplicated content removed (content remains in the imported fragments); wording neutralized, not dropped