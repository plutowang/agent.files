# Next-Session Handoff — Wording-Optimization Task

**Date:** 2026-08-12
**Purpose:** Archive the completed refactor state and provide a paste-ready prompt for the next session (context will be compacted; this doc preserves everything needed).

---

## PART A — ARCHIVE: Current State (what the new session inherits)

### The system
- **agent.files** = an AUPC prompt-compiler repo. Single source of truth in `_core/`, compiled into IDE-specific formats (opencode, cursor) by the Zig compiler `agentc` (`./agentc-cli build` → `dist/`; `./agentc-cli link <ide>` → symlink).
- **Import mechanism:** `<!-- @import path -->` directives, inlined at directive position (`agentc/core/compiler.zig:55-57`). Imports are repo-root-relative.

### Architecture (rev. 4 — fragment-based pyramid assembly)
- **`_core/` = tag-free, heading-free fragments** in concept folders: `<concept>/redlines.md`, `protocol.md`, `standards.md`, `memory.md`, `preflight.md` (only sections the concept has). 32 concept folders (governance 7, workflows 8, engineering 6, refactoring 3, commands 6 + review). Fragments may import same-section-type fragments (root-relative).
- **Shells (opencode/, cursor/) = thin import containers:** frontmatter + XML skeleton (`<red_lines>` → `<execution_protocol>` → [`<standards>`] → [`<formatting_and_memory>`] → [`<pre_flight_check>`]) + imports inside matching sections + minimal IDE glue (agent names, `$ARGUMENTS`, cursor `/`-interlocks). NO format symbols as shell-own content.
- **`dist/` = compiled, independently deployed.** No internal path references survive (except source-repo agents like evolver, which legitimately reference `_core/`/`opencode/`).
- **Skills (`_core/skills/*/SKILL.md`) = standalone** (shipped verbatim, not imported) — keep their own pyramid.

### Canonical format spec (in `_core` fragments)
- `redlines.md` — plain bullets `- `; bold labels ONLY for grouping; NO tables, NO numbered lists, NO bold-prefixed items (exception: the two TDD Iron Law lines keep bold)
- `protocol.md` — bold labels for subsections; numbered steps for sequences; plain bullets for non-sequential
- `standards.md` / `memory.md` — bold labels + bullets + tables (reference data)
- `preflight.md` — `- [ ]` checkboxes

### Hard rules for editing (from agent-architect skill + session decisions)
1. **Zero-loss:** every constraint retained; wording may be adjusted but necessary information never dropped. Audit matrix per change (count IN == OUT).
2. **Lexical Ban (`_core/` only):** no `glob`, `grep`, `Task` tool, `build` subagent, `YAML frontmatter`, `@Codebase`, `.mdc`.
3. **IDE-neutrality:** no IDE-specific agent names in `_core` (use role names: "the security review agent"); shells supply names (opencode: `security-reviewer`; cursor: `/security-auditor`).
4. **`edit_accuracy/memory.md`:** importable ONLY by write-enabled agents (build, refactor, docs, build-error-resolver).
5. **Permission alignment:** prompt text must match the shell's YAML permission block.
6. **Cursor hygiene:** `alwaysApply: false` + globs; `/`-syntax interlocks; no OpenCode mechanics.
7. **Frontmatter byte-identical** except density-rewritten descriptions (trigger-accurate, third person, what+when).
8. **`dist/` never edited** — verify via rebuild + read-back.
9. **HITL gates:** plan approval before multi-file changes; present per-phase; wait.
10. **Verification:** `zig build test` → EXIT 0; `./agentc-cli build` → SUCCESS; dist read-back (one of each tag per shell, no fragment headings, no within-file duplication, no internal path refs).

### Known remaining items
1. **3 over-budget shells** (>200 lines; lazy-load `<standards>` recommendation documented):
   - `opencode/agents/build.md` (287) — imported `code_standards/standards.md` (~200 lines)
   - `opencode/commands/review.md` (274)
   - `cursor/agents/code-reviewer.md` (282)
   - Fix: replace the `<standards>` import with "Read `_core/3_engineering/code_standards/standards.md` before writing code" (two-tier offloading; build/verifier have `read` permission ✅). **User approved this approach for the next session.**
2. **Uncommitted work:** Phases 3–6 + all passes are applied but NOT committed (checkpoints 1–2 committed: `d911afd`, `9f7ac9b`, `76cc908`).
3. **`opencode/opencode.json`** — pre-existing staged MCP version bump (unrelated; include/exclude at commit).
4. **`docs/` is gitignored** — plan/audits/context live on disk only.

### Key files (read order for the new session)
1. `docs/context/2026-08-12-refactoring-session-context.md` — full session picture (this archive's parent)
2. `docs/plans/2026-08-12-high-density-refactor.md` (rev. 24) — living tracker
3. `docs/research/2026-08-12-agent-prompt-best-practices.md` — 2025–2026 primary-source research (Anthropic/OpenAI/Google/IDE/academic)
4. `docs/refactoring/00-pilot.md` … `09-redundancy-fixes.md` — phase audits (audit-matrix format + verification evidence)
5. `ARCHITECTURE.md` — repo architecture overview
6. `.agents/skills/agent-architect/SKILL.md` — governance rules for editing this repo (MANDATORY)

---

## PART B — NEXT-SESSION PROMPT (paste into the new session)

```markdown
You are working in the agent.files repository — an AUPC prompt-compiler. `_core/` holds
tag-free, heading-free rule fragments in concept folders (redlines/protocol/standards/
memory/preflight); shells (opencode/, cursor/) are thin import containers (frontmatter +
XML skeleton + `<!-- @import -->` lines + minimal IDE glue); `dist/` is the compiled,
independently-deployed output generated by `./agentc-cli build` (never edit dist directly).

MANDATORY first steps:
1. Load the `agent-architect` skill (governance rules for editing this repo).
2. Read `docs/context/2026-08-12-refactoring-session-context.md` (full session picture),
   `docs/plans/2026-08-12-high-density-refactor.md` (living tracker), and
   `docs/research/2026-08-12-agent-prompt-best-practices.md` (existing research).
3. Run `./agentc-cli build` to confirm the current state compiles, then read `dist/`
   to understand the compiled output.

TASK — improve prompt quality without reducing it:
1. EVALUATE dist/: read every compiled file. Identify wording that is imprecise,
   verbose, ambiguous, or redundant. Propose rewrites that are MORE accurate with
   FEWER words. Also evaluate rule quality: do the rules make agents work at high
   quality? Are there gaps, contradictions, or weak phrasings?
2. FIX OVER-BUDGET LINES: `opencode/agents/build.md` (287 lines), `opencode/commands/
   review.md` (274), `cursor/agents/code-reviewer.md` (282) exceed the 200-line
   best-practice budget. Apply the approved fix: replace the `<standards>` import of
   `_core/3_engineering/code_standards/standards.md` with a lazy-load reference
   ("Read `_core/3_engineering/code_standards/standards.md` before writing code").
   Verify each file drops under 200 lines.
3. DEEPER RESEARCH: extend the research doc with new primary sources (2025–2026) on
   prompt wording precision, conciseness, and instruction-following quality. Cite
   every claim (URL). Apply validated findings to the prompts.
4. IMPROVE RULES: based on research + dist evaluation, refine `_core` fragments and
   shells for higher-quality agent behavior.

HARD CONSTRAINTS (non-negotiable):
- ZERO-LOSS: every constraint retained. Wording may be adjusted; necessary information
  never dropped. Produce an audit matrix per change (constraint count IN == OUT).
- Do NOT reduce configs/prompts quality. Do NOT restrict permissions. The main branch
  holds the original configs — do not degrade them; changes must be net improvements.
- Lexical Ban in `_core/`: no `glob`, `grep`, `Task` tool, `build` subagent, `YAML
  frontmatter`, `@Codebase`, `.mdc`.
- IDE-neutrality: no IDE-specific agent names in `_core` (role names only); shells
  supply names (opencode: `security-reviewer`; cursor: `/security-auditor`).
- `edit_accuracy/memory.md` importable ONLY by write-enabled agents.
- Permission alignment: prompt text must match each shell's YAML permission block.
- Cursor `.mdc` hygiene: `alwaysApply: false` + globs; `/`-syntax interlocks.
- Frontmatter byte-identical except density-rewritten descriptions (trigger-accurate,
  third person, what+when, ≤1024 chars).
- Canonical format spec: redlines = bullets only (no tables/numbered/bold-prefixed
  items); protocol = bold labels + numbered steps per subsection; standards/memory =
  bold labels + bullets/tables; preflight = `- [ ]` checkboxes.
- `dist/` never edited — verify via rebuild + read-back (one of each XML tag per
  shell, no fragment headings, no within-file duplication, no internal path refs).
- HITL: present a plan before multi-file changes; wait for approval; present results
  per phase; wait.

PROCESS:
1. Plan (write to docs/plans/YYYY-MM-DD-<slug>.md) → await approval.
2. Execute in phases (dist evaluation → over-budget fix → research → rule refinement),
   each ending with verification: `zig build test` (EXIT 0) + `./agentc-cli build`
   (SUCCESS) + dist read-back.
3. Write audits to docs/refactoring/10-*.md with per-change audit matrices.
4. Sync docs/context/ + docs/plans/ after each phase.
5. Do NOT commit unless explicitly instructed.
```
