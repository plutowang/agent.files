# Session Context — Agent.files Ultra-High-Density Refactor (2026-08-12)

**Purpose of this document:** Complete handoff for a NEW session. Read this first — it captures the full context of the ongoing refactoring of the `agent.files` repository: the architecture, the research foundation, every decision, every gate, the exact current state, and the precise resume path. Nothing here should need to be re-derived.

**Companion artifacts** (read for depth when needed): the living plan `docs/plans/2026-08-12-high-density-refactor.md` (rev. 14 — COMPLETE), research `docs/research/2026-08-12-agent-prompt-best-practices.md`, audits `docs/refactoring/00-pilot.md` … `07-cursor.md`.

**Suggested reading order for a new session:** (1) this document — full picture; (2) the plan — living tracker with per-file status and gates; (3) the latest phase audit (`07-cursor.md`) — the audit-matrix format and verification evidence.

---

## 1. TL;DR — The Mission

Refactor every prompt/rule file in the `agent.files` repository (~100 files, ~31k words) into an **ultra-high-density, zero-loss, command-style format**: a pyramid attention layout with semantic XML isolation, imperative encoding, and **100% constraint retention** proven by per-concept audit matrices.

**The architecture that emerged (rev. 4 — current):**
- **XML tags live ONLY in host shells** (`opencode/`, `cursor/`). Each shell owns a canonical skeleton: `<red_lines>` → `<execution_protocol>` → `<standards>` → `<formatting_and_memory>` → `<pre_flight_check>`.
- **`_core/1~5` = tag-free, heading-free fragments** organized as concept folders: `<concept>/redlines.md`, `protocol.md`, `standards.md`, `memory.md`, `preflight.md` (only the sections the content actually has).
- Shells import fragments **inside the matching XML section** via `<!-- @import _core/... -->` (compiler inlines at directive position — verified `agentc/core/compiler.zig:55-57`).
- Fragments may import same-section-type fragments (root-relative paths); cross-section deps are hoisted to shells.
- Skills (`_core/skills/*/SKILL.md`) keep their own pyramid — they are standalone artifacts shipped verbatim, not imported.

**Why this architecture:** the previous scheme (XML inside `_core` files) produced two defects in compiled output: (1) duplicate/nested XML tags (`<execution_protocol>` inside `<execution_protocol>`), (2) imported markdown headings polluting shell hierarchy (`# Implementation Phase` inside build.md). Both are now fixed and verified.

**Status:** ✅ **PROJECT COMPLETE** — Phases 0–6 DONE (32 concept folders, 59+ fragments, all host shells thin import containers, all 25 skills compliant, format simplified, zero redundancy, dist independence verified, explore permissions fixed). Remaining user actions: `./agentc-cli link <ide>`; commit Phases 3–6 + all passes; **next task: wording-optimization session (see §15 + handoff doc)**.

---

## 2. The Repository

- **What it is:** a compiler for AI prompts. Single Source of Truth in `_core/` compiled into IDE-specific formats (OpenCode, Cursor, Copilot) by a custom Zig compiler `agentc` (`./agentc-cli build`).
- **Dependency injection:** `<!-- @import path/to/file.md -->` — recursive, inlined at directive position, root-relative paths.
- **Directory paradigm:**
  - `_core/1_governance/` — supreme laws (HITL, anti-loop, safety)
  - `_core/2_workflows/` — process flows (git ops, feature dev, triage)
  - `_core/3_engineering/` — quality standards (architecture, testing, security)
  - `_core/4_refactoring/` — tech debt management
  - `_core/5_commands/` — slash command core logic
  - `_core/skills/` — atomic capabilities (SKILL.md per skill)
  - `opencode/`, `cursor/`, `copilot/` — host shells (frontmatter + glue + imports)
  - `dist/` — **generated output, NEVER edited** (gitignored)
  - `agentc/` — the Zig compiler (no changes expected)
  - `docs/` — **gitignored** (repo convention): plans, specs, research, audits, context
- **Compiler targets:** `opencode/` + `cursor/` only (config.zig); `copilot/` exists as a third target under the extensibility protocol but is out of scope.
- **Build:** `zig build test` (compiler tests) + `./agentc-cli build` (104 files) + `./agentc-cli link <ide>`.

## 3. The Pyramid Schema (canonical skeleton)

Every host shell owns this structure (sections used as needed):

```markdown
<red_lines>            Position 0 — hard prohibitions, safety, non-negotiables
<execution_protocol>   Position 1 — role identity, workflow, state machine
<standards>            Position 1.5 — engineering standards (added rev 3)
<formatting_and_memory> Position 2 — output format, dynamic context loading
<pre_flight_check>     Position 3 — lean self-verification; each red line echoed in one line
```

**Research basis (2025–2026 primary sources):** XML tags endorsed by Anthropic/OpenAI/Google; instructions best recalled at prompt END (Anthropic) while Google says constraints FIRST → red lines at top + pre-flight re-anchoring at end; MUST/NEVER reserved for invariants (aggressive language over-triggers on Opus 4.5/4.6+); "state each instruction once" (OpenAI); line/char budgets NOT word budgets (CLAUDE.md <200 lines, SKILL.md <500 lines, description ≤1024 chars). Full citations: `docs/research/2026-08-12-agent-prompt-best-practices.md`.

### Fragment filename → XML section mapping (canonical)

| Fragment file in concept folder | Imported into shell section |
|---|---|
| `redlines.md` | `<red_lines>` |
| `protocol.md` | `<execution_protocol>` |
| `standards.md` | `<standards>` |
| `memory.md` | `<formatting_and_memory>` |
| `preflight.md` | `<pre_flight_check>` |

**Audit matrix format** (per concept, written to `docs/refactoring/<phase>.md`): `| # | Original constraint | Fragment + location | Status (100% Preserved) |` — one row per inventory item; count OUT must equal count IN. Example from `03-engineering-refactoring.md`.

## 4. Non-Negotiable Rules

1. **Lexical Ban (`_core/` only):** forbidden words — `glob`, `grep`, `Task` tool, `build` subagent, `YAML frontmatter`, `@Codebase`, `.mdc`.
2. **Fragments:** NO XML tags, NO markdown headings (bold labels `**Step 1: …**` instead). Code-fenced template content (e.g., ADR template inside ```markdown) is exempt — literal output examples, not structural headings.
3. **`edit_accuracy/memory.md`:** importable ONLY by write-enabled agents (`build`, `refactor`, `docs`, `build-error-resolver`). Never read-only agents or global files.
4. **IDE-neutral `_core`:** no IDE-specific agent names in fragments (e.g., "dedicated security review agent" — opencode shells supply `security-reviewer`, cursor shells supply `/security-auditor`).
5. **Frontmatter preserved** byte-identical (permission blocks, descriptions). Skill descriptions ≤1024 chars, no XML in frontmatter.
6. **OpenCode alignment:** prompt text MUST match YAML permission blocks.
7. **Cursor `.mdc` hygiene:** `alwaysApply: false` + specific globs; `/`-syntax interlocks; no OpenCode mechanics.
8. **`dist/` never edited** — verify via rebuild + read-back only.
9. **Zero-loss:** every constraint retained; section placement decided by content, never convenience; per-concept audit matrix (count OUT == IN).
10. **Skills keep their own pyramid** (standalone, shipped verbatim).

## 5. Progress State

### Done (Phases 0–6) — PROJECT COMPLETE

**Fragments:** 28 concept folders / 59 fragments in `_core/` (governance 6, workflows 6, engineering 6, refactoring 3, commands 7) — all tag-free, heading-free, parity-verified.
**Shells with canonical skeletons:** all opencode agents (12) + rules (2) + commands (8); all cursor agents (7) + rules (9) + commands (7). `tokenscope.md` (no imports) and `cursor/commands/review.md` (pure delegation) are the only non-skeleton shells — by design.
**Skills:** all 25 refactored to own pyramid (≤500 lines, descriptions ≤1024 chars).
**Commands:** all 7 `_core/5_commands` concepts are folders; 12 command shells rebuilt (Phase 3).

**Fragment inventory (28 folders / 59 fragments):** governance — anti_loop (redlines/protocol/memory/preflight), invariants (redlines), execution_safety (redlines), hitl_gates (redlines/protocol/memory), edit_accuracy (memory), skills_manifest (memory); workflows — feature_dev_build (redlines/protocol/preflight), feature_dev_design (protocol), documentation (redlines/protocol/memory), error_triage (redlines/protocol), communication (memory), gitlab_context (protocol); engineering — testing_aaa (standards/redlines/protocol/preflight), code_standards (standards/redlines), code_review (protocol/redlines/memory), security_audit (redlines/standards/protocol/preflight/memory), architecture (protocol/standards/redlines/memory), api_contracts (standards); refactoring — smell_detection (redlines/standards/protocol), extraction_patterns (standards), refactor_persona (protocol/redlines/memory); commands — commit (redlines/protocol/memory), explain/fix/test/security/refactor (protocol), review (redlines/protocol/preflight).

**Examples:** `opencode/.examples/example_command.md`, `cursor/.examples/example_AGENTS.md`, `cursor/.examples/example_subagent.md` — repointed to fragment imports.

### Pending

NONE — all phases complete. Remaining user actions: `./agentc-cli link <ide>`; commit Phases 3–6 (commit message + CHECKPOINT 3 available on request); optional format-consistency pass (see §14).

## 6. Verification Protocol (every phase)

1. `zig build test` → EXIT 0 (no import/frontmatter breakage)
2. `./agentc-cli build` → SUCCESS, 104 files
3. dist read-back: exactly ONE of each XML tag per shell; zero fragment headings; no cross-IDE contamination
4. Audit matrix: count OUT == count IN per concept
5. Line-budget check (200-line shells, 500-line skills/`.mdc`)
6. XML-frontmatter check (no tags in YAML; skill descriptions ≤1024 chars)

## 7. Git History & Checkpoints

| Commit | Content |
|---|---|
| `d911afd` | **CHECKPOINT 1** — `refactor(core): fragment-based pyramid assembly for agent prompts` (rev-4 rework: 13 folders, 25 fragments, 6 shells, 13 deletions, 23 reference fixes) |
| `9f7ac9b` | **CHECKPOINT 2** — `refactor(engineering): convert engineering and refactoring rules to heading-free fragments` (Phase 2: 9 concepts → 26 fragments, 27 importers, `**Process**` labels, 2 prose fixes) |
| `76cc908` | `docs: track high-density refactor artifacts` |

**Note (RESOLVED):** `opencode/opencode.json` carried a PRE-EXISTING staged MCP version bump (unrelated to the refactor). It was included in the checkpoint commits. No action needed.
**Note (CURRENT):** Phases 3–6 changes (commands, skills, opencode shells, cursor shells) are applied but **NOT YET COMMITTED** — commit message + CHECKPOINT 3 available on request.

## 8. Decision Log (chronological, all user-approved)

1. Phased full rollout, pilot first
2. XML tags in markdown (house style change accepted)
3. Audit matrices → `docs/refactoring/`
4. All 7 research findings incorporated (line budgets, moderated imperatives, pre-flight re-anchoring, body-only XML, Codex note)
5. Gate 1: plan rev 2 → Phase 0
6. Gate 2: pilot approved → Phase 1
7. Import-gap direction: review `dist/` first, design extraction for opencode/cursor/future
8. Rev 3: Compiled-Pyramid Contract (imports inside sections, IDE-neutral `_core`, minimal shells)
9. Rev 3.1: content-driven mapping — NO blanket `<standards>` placement
10. Gate 2.5: permission granted
11. Gate 3.5: rev 4 fragment rework approved (Option 3 — concept folders; XML only in shells; fragments tag-free/heading-free)
12. Gate 4: Phase 2 approved
13. Gate 5: Phase 3 approved ("approve to continue next Phase") + applied
14. Gate 6: Phase 4 approved ("Approve Phase 4") + applied
15. Gate 7: Phase 5 approved ("approve to Phase 5") + applied
16. Gate 8: Phase 6 approved ("approve to Phase 6") + applied — **PROJECT COMPLETE**

## 9. Gates

- ✅ 1 (plan rev. 2) · ✅ 2 (pilot) · ✅ 2.5 (permission) · ✅ 3.5 (rev-4 rework) · ✅ 4 (Phase 2) · ✅ 5 (Phase 3) · ✅ 6 (Phase 4) · ✅ 7 (Phase 5) · ✅ 8 (Phase 6) — **ALL PASSED, PROJECT COMPLETE**

## 10. Known Issues & Notes

1. **Code-fenced templates** (intentional, NOT bugs): `# ADR-XXX`/`## Status` in `architecture/memory.md`, `## Refactor Plan: {Title}` in `refactor_persona/memory.md`, `## Requirements (from GitLab)` in `gitlab_context/protocol.md` — inside ```markdown fences as literal output examples; do not render as headings. Converting them would change emitted template formats (violates zero-loss).
2. **Shell-own headings are legitimate** (`## Process`, `## Rules`, `## Do NOT`, `## Context & File Access` in agent bodies) — they are the shell's own structure, not fragment-injected.
3. **`docs/` is gitignored** — plan/audits/context live on disk only, never committed.
4. **`dist/` is gitignored** — always rebuild, never edit.
5. **Permission environment:** this session experienced mid-session permission changes (writes to `_core/`/`opencode/`/`cursor/` were denied at one point, then granted). If writes are denied, stage content in `docs/` and ask the user.
6. **Tooling:** `grep`/`find`/`rg` are DENIED in bash — use the `explore` subagent for searches; `wc`, `ls`, `git status/diff/log`, `zig build test`, `./agentc-cli build` are allowed.
7. **Suggested CI check (from audit):** reject `^#{1,4}` lines in `_core/**` outside `_core/skills/` and outside code fences.
8. **Codex 32 KiB AGENTS.md cap** — flag if a Codex target is ever added to `agentc`.

## 11. How to Resume (exact next steps)

1. **Project complete.** Remaining user actions: run `./agentc-cli link <ide>`; commit Phases 3–6 (commit message + CHECKPOINT 3 available on request).
2. **Optional format-consistency pass** (user-requested, see §14): standardize content format inside XML tags across compiled files.
3. After any future change: `zig build test` + `./agentc-cli build` + dist read-back (one of each tag per shell, zero fragment headings).

## 12. Artifact Index

| Artifact | Path |
|---|---|
| **THIS document** | `docs/context/2026-08-12-refactoring-session-context.md` |
| Primary plan (living tracker, rev. 14 — COMPLETE) | `docs/plans/2026-08-12-high-density-refactor.md` |
| Research (primary sources, cited) | `docs/research/2026-08-12-agent-prompt-best-practices.md` |
| Phase 0 pilot audit | `docs/refactoring/00-pilot.md` |
| Phase 1 staging kit (superseded) | `docs/refactoring/01-governance-workflows-staged.md` |
| Phase 1 audit (superseded) | `docs/refactoring/01-governance-workflows.md` |
| Rev-4 rework audit | `docs/refactoring/02-fragment-rework.md` |
| Rev-4 staging kit (superseded) | `docs/refactoring/02-fragment-rework-staged.md` |
| Verification audit | `docs/refactoring/03-verification-audit.md` |
| Phase 2 audit — Engineering + Refactoring | `docs/refactoring/03-engineering-refactoring.md` |
| Phase 3 audit — Commands | `docs/refactoring/04-commands.md` |
| Phase 4 audit — Skills | `docs/refactoring/05-skills.md` |
| Phase 5 audit — OpenCode shells | `docs/refactoring/06-opencode.md` |
| Phase 6 audit — Cursor shells (FINAL) | `docs/refactoring/07-cursor.md` |
| Format-consistency pass (staged) | `docs/refactoring/08-format-consistency.md` |

## 13. Key Paths

- Compiler: `agentc/core/compiler.zig` (import inlining at directive position), `agentc/core/config.zig` (targets), `agentc/commands/build_cmd.zig` (only processes opencode/ + cursor/ + copies _core/skills/)
- Governance skill docs (reference the architecture): `.agents/skills/agent-architect/SKILL.md`, `agent-ingestor/SKILL.md`, `aupc-auditor/SKILL.md`
- Stale-reference audit command: `.opencode/commands/agentfile-audit.md`

## 14. Format-Consistency Pass (APPLIED — rev. 2 + simplification, 2026-08-12)

**Status:** APPLIED + VERIFIED. Principle (user-directed): ALL format symbols live INSIDE `_core` imported files; shells are thin import containers.

**Simplified canonical format (user: "make the format simple, use necessary format"):**
- `redlines.md` — plain bullets `- `; bold labels ONLY for grouping; NO tables, NO numbered lists, NO bold-prefixed items (exception: the two TDD Iron Law lines keep bold — supreme-law emphasis)
- `protocol.md` — bold labels for subsections; numbered steps for sequences; plain bullets for non-sequential
- `standards.md` / `memory.md` — bold labels + bullets + tables (reference data)
- `preflight.md` — `- [ ]` checkboxes

**Applied:** invariants table → bullets; testing_aaa Rationalizations table → bullets; architecture numbered anti-patterns → bullets; bold-prefixed items stripped (error_triage, explore, evolver, smell_detection, feature_dev_build, feature_dev_design, agent_constraints); verified in dist read-back (uniform red_lines in build.md).

**Canonical format spec (in `_core` fragments):** `redlines.md` = bold labels + bullets, NO numbered lists; `protocol.md` = bold labels + numbered steps per subsection; `standards.md`/`memory.md` = bold labels + bullets/tables; `preflight.md` = `- [ ]` checkboxes.

**Part 1 — `_core` normalization:** preflight → checkboxes (anti_loop, feature_dev_build + verification-gate bullet added, review).

**Part 2 — shell content extracted into `_core`:** merged into feature_dev_build (redlines/protocol/memory/preflight), error_triage (redlines/protocol/memory), testing_aaa (redlines/protocol/memory), security_audit (redlines/memory), architecture (redlines/protocol), refactor_persona (redlines/protocol), code_review (protocol/memory), feature_dev_design (redlines/protocol/memory); NEW concepts: `_core/2_workflows/explore/`, `_core/2_workflows/evolver/`, `_core/1_governance/orchestration/`, `_core/1_governance/agent_constraints/`. IDE-specific content stays in shells (cursor `/`-names, opencode `$ARGUMENTS`/grep/glob glue, delegation names neutralized in `_core`).

**Part 3 — dedup/anomalies:** security + review duplicate process imports removed (4 shells); security-auditor Rules label renamed to Auditor Rules.

**Over-budget shells (documented for future session — user chose NOT to lazy-load now):**

| File | Lines | Budget | Cause | Future fix |
|---|---|---|---|---|
| `opencode/agents/build.md` | 287 | <200 | imported code_standards/standards.md (~200 lines) | lazy-load `<standards>` import: "Read `_core/3_engineering/code_standards/standards.md` before writing code" |
| `opencode/commands/review.md` | 274 | <200 | imported standards | same (drops to ~207 after format-pass fix D) |
| `cursor/agents/code-reviewer.md` | 282 | <200 | imported standards | same (drops to ~215 after fix D) |

All other files within budget (skills ≤445/500, .mdc ≤181/500). build/verifier have `read` permission ✅ so lazy-loading is viable.

## 15. NEXT TASK — Wording-Optimization Session (handoff prepared)

**Handoff doc + next-session prompt:** `docs/context/2026-08-12-next-session-handoff.md`

**Task scope (user-defined):**
1. Evaluate `dist/` — improve prompt wording (more accurate, fewer words)
2. Fix the 3 over-budget shells (build 287, review 274, cursor code-reviewer 282 — lazy-load `<standards>` recommendation)
3. Do deeper research on prompt-wording best practices (extend `docs/research/2026-08-12-agent-prompt-best-practices.md`)
4. Improve rules so agents work at high quality
5. **Hard constraints:** do NOT reduce configs/prompts quality; do NOT restrict permissions; zero-loss wording changes; main branch holds the original configs (do not degrade them)

**Architecture the new session must understand:** `_core/` = tag-free, heading-free fragments in concept folders (redlines/protocol/standards/memory/preflight); shells (opencode/, cursor/) = thin import containers (frontmatter + XML skeleton + imports + IDE glue); `dist/` = compiled, independently deployed (no internal path references except source-repo agents like evolver).
---

## §16 — Wording-Optimization Session (2026-08-15) — COMPLETE

**Scope:** precision/conciseness/rule-quality pass over all compiled prompts (104 dist files). 5 phases, all gated, all verified.
**Decisions:** no lazy-load (wording tightening only); reword+dedup+add authority; research incl. DeepSeek/MiniMax/Moonshot; Phase 5 re-tighten added by user.
**Key outcomes:**
- Compiled output 5202 → 4271 lines (−17.9%); the 5 over-budget files: build 304→190, code-reviewer 263→160, review 253→153, architect 213/207→195/185 — all ≤200 fully inline.
- Zero-loss: audit matrices per change (IN==OUT); 7 contradiction classes fixed (verifier-rules placement, search rule, capability table, escalation, role leakage in .mdc rules, verifier write-protocol, loop order); frontmatter byte-identical; no permission changes.
- Research doc extended with 44 verified findings (OpenAI 10–15% leaner-prompt gain, MiniMax/Kimi/DeepSeek V4-Pro official docs, 18 academic papers); verification note: docs/research/2026-08-15-verification-note.md.
- 2 authoring-time additions in agent-architect skill: state-each-rule-once; rule-count budget ~40.
- New fragments: _core/3_engineering/testing_aaa/verifier_rules.md + verification_protocol.md.
**Artifacts:** docs/specs/2026-08-15-wording-optimization.md · docs/plans/2026-08-15-wording-optimization.md · docs/plans/2026-08-15-phase4-rule-refinement.md · docs/refactoring/10-dist-evaluation.md, 11-over-budget.md, 12-research-extension.md, 13-rule-refinement.md, 14-final-review-retighten.md.
**Status:** partially committed — user commit `ddb690f` covered Phase-2 work + audits 10/11; Phases 3–5 remain uncommitted (agent performed no git operations).
**Archive:** `docs/context/2026-08-15-wording-optimization-handoff.md` (Part A = final state, Part B = next-session considerations).
**Authoring guide:** `docs/guides/2026-08-15-prompt-authoring-guide.md` — mandatory for future prompt/skill/rule creation; referenced from agent-architect skill §8.
