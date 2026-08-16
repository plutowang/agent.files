# Plan: Ultra-High-Density Zero-Loss Refactor of agent.files Knowledge Base

**Date:** 2026-08-12 (rev. 25 — FINAL: handoff archived for next session)
**Status:** ✅ **PROJECT COMPLETE** — Phases 0–6 + all passes + verification + explore permission fixes. **Handoff archived:** `docs/context/2026-08-12-next-session-handoff.md` (archive + paste-ready next-session prompt for the wording-optimization task). Remaining: user runs `./agentc-cli link <ide>`; commit Phases 3–6 + all passes; next session = wording optimization (evaluate dist, fix 3 over-budget shells via lazy-load, deeper research, rule refinement — zero-loss, no quality reduction, no permission restriction).
**Scope:** `_core/`, `opencode/`, `cursor/` — ~100 files, ~31,000 words
**Out of scope:** `copilot/` (not in requested input; revisit under extensibility protocol if desired), `dist/` (generated — never edited), `agentc/` (compiler — no changes expected)
**Research basis:** `docs/research/2026-08-12-agent-prompt-best-practices.md` — 2025–2026 primary-source validation (Anthropic, OpenAI, Google, IDE docs, academic literature)

---

## 0c. POST-COMPLETION ITEMS (2026-08-12, user decisions)

1. **Format-consistency pass — APPLIED (rev. 2, 2026-08-12).** Principle: all format symbols live INSIDE `_core` fragments; shells are thin import containers (frontmatter + XML skeleton + imports + minimal IDE glue). Part 1: preflight fragments → checkboxes (anti_loop, feature_dev_build + verification-gate bullet, review); feature_dev_build/preflight.md extended. Part 2: extracted shell content into `_core` — merged into feature_dev_build (redlines/protocol/memory/preflight), error_triage (redlines/protocol/memory), testing_aaa (redlines/protocol/memory), security_audit (redlines/memory), architecture (redlines/protocol), refactor_persona (redlines/protocol), code_review (protocol/memory), feature_dev_design (redlines/protocol/memory); NEW concepts: `_core/2_workflows/explore/`, `_core/2_workflows/evolver/`, `_core/1_governance/orchestration/`, `_core/1_governance/agent_constraints/`. IDE-specific content stays in shells (cursor `/`-names, opencode `$ARGUMENTS`/grep/glob glue). Part 3: dedup security/review process imports (4 shells); security-auditor Rules label renamed. Verified: `zig build test` EXIT 0; build SUCCESS 104 files; dist read-back shows thin shells + unified format.
2. **Over-budget shells — DOCUMENTED for future session (user decision: format only, no lazy-load now).** 3 compiled shells exceed the 200-line best-practice budget:
   - `opencode/agents/build.md` — 287 lines (imported code_standards/standards.md ~200 lines)
   - `opencode/commands/review.md` — 274 lines (imported standards; ~207 after format-pass fix D)
   - `cursor/agents/code-reviewer.md` — 282 lines (imported standards; ~215 after fix D)
   **Recommended future fix:** lazy-load the `<standards>` imports (two-tier offloading per research): replace the import with "Read `_core/3_engineering/code_standards/standards.md` before writing code". build/verifier have `read` permission ✅. All other files within budget (skills ≤445/500, .mdc ≤181/500).

---

## 0b. CHECKPOINT 2 (2026-08-12)

**Commit:** `9f7ac9b refactor(engineering): convert engineering and refactoring rules to heading-free fragments` (+ `76cc908 docs: track high-density refactor artifacts`) — committed 2026-08-12; Phase 3 changes applied but not yet committed (pending user commit)
**State at checkpoint:**
- ✅ Gates 1, 2, 2.5, 3.5, 4 passed
- ✅ Phase 2 applied + verified: 9 concepts → 26 fragments (69/69 content-block parity), 27 importers repointed, `## Process` → `**Process**` in 5 command files, 2 stale prose refs fixed
- ✅ Cumulative: 22 concept folders / 51 fragments, 251/251 parity (Phases 0–2)
- ✅ Verification: `zig build test` EXIT 0; `./agentc-cli build` SUCCESS 104 files; dist re-audit: XML tags 100% clean, all real fragment headings cleared (7 remaining flagged lines are intentional code-fenced templates)
- ⚠️ Remaining: Phase 3 (6 command concepts + command shell skeletons), Phase 4 (24 skills), Phase 5 (opencode shells), Phase 6 (cursor shells)
- ℹ️ `opencode/opencode.json` staged MCP bump is pre-existing, unrelated to refactor — decide include/exclude at commit
- ℹ️ `docs/` is gitignored (repo convention) — plan/audits live on disk only

**Resume from checkpoint:** Gate 5 approval → Phase 3 (Commands: commit, fix, security, explain, refactor, test → concept folders + opencode/cursor command shell skeletons) → Phase 4 (Skills) → Phase 5 (OpenCode shells) → Phase 6 (Cursor shells).

---

## 0. CHECKPOINT 1 (2026-08-12)

**Commit:** `d911afd refactor(core): fragment-based pyramid assembly for agent prompts` — committed 2026-08-12, working tree clean
**State at checkpoint:**
- ✅ Gates 1, 2, 2.5, 3.5 passed; rev. 4 fragment rework applied + verified
- ✅ 13 concept folders, 25 fragments, 182/182 constraint parity
- ✅ 6 shells rebuilt (build, agent-core, review command, cursor code-reviewer, AGENTS.md, examples)
- ✅ 11 stale imports + 16 examples/README/skill references repointed; 13 flat files deleted
- ✅ Verification: `zig build test` EXIT 0; `./agentc-cli build` SUCCESS 104 files; full dist audit (`docs/refactoring/03-verification-audit.md`): XML tags 100% clean, imports 100% resolve, no cross-IDE contamination
- ⚠️ ~~Heading pollution in 22 compiled files~~ → **RESOLVED by Phase 2** (real headings cleared; only intentional code-fenced templates remain)
- ⚠️ ~~2 stale prose refs~~ → **RESOLVED** (ARCHITECTURE.md:58, .opencode/commands/agentfile-audit.md:16)
- ℹ️ `opencode/opencode.json` staged MCP bump is pre-existing, unrelated to refactor — decide include/exclude at commit
- ℹ️ `docs/` is gitignored (repo convention) — plan/audits live on disk only

**Resume from checkpoint:** Gate 5 approval → Phase 3 (Commands: commit, fix, security, explain, refactor, test → concept folders + command shell skeletons) → Phase 4 (Skills, 24 remaining) → Phase 5 (OpenCode shells) → Phase 6 (Cursor shells).

---

## 1. CURRENT STATE (read this first to resume)

| Item | Status |
|---|---|
| **Gates 1, 2, 2.5, 3.5, 4** | ✅ Passed |
| **Phase 0/0.5/1** | ✅ Applied under rev-3 scheme, then **reworked to rev-4 fragments** |
| **Rev. 4 fragment rework** | ✅ APPLIED + VERIFIED — 25 fragments, 6 shells, 13 deletions, 23 stale-reference fixes; audit `docs/refactoring/02-fragment-rework.md` |
| **Phase 2 — Engineering + Refactoring** | ✅ APPLIED + VERIFIED — 9 concepts → 26 fragments, 69/69 parity, 27 importers repointed; audit `docs/refactoring/03-engineering-refactoring.md` |
| **Phases 3–6** | ⏳ Pending — Gate 5 approval required before Phase 3 |
| **Verification evidence** | `zig build test` EXIT 0; `./agentc-cli build` SUCCESS 104 files; dist re-audit (46 files): XML tags 100% clean, imports 100% resolve, no cross-IDE contamination, all real fragment headings cleared (only intentional code-fenced templates remain) |

**Rev. 4 architecture (current):** XML tags exist ONLY in host shells. `_core/1~5` = tag-free, heading-free fragments in concept folders (`<concept>/redlines.md`, `protocol.md`, `memory.md`, `preflight.md`). Shells own the canonical skeleton and import fragments inside matching tags. Fragment-level same-section imports allowed (e.g., `review/protocol.md` → `gitlab_context/protocol.md`).

### Per-file progress tracker

| File | Phase | Status |
|---|---|---|
**Fragments (rev. 4 + rev. 2 format pass, applied):** 32 concept folders — the 28 from Phases 0–3 plus 4 new: `_core/2_workflows/explore/` (redlines/protocol/memory), `_core/2_workflows/evolver/` (redlines/protocol), `_core/1_governance/orchestration/` (standards/protocol), `_core/1_governance/agent_constraints/` (redlines/standards).
| Concept folder | Fragments | Parity |
|---|---|---|
| `_core/1_governance/anti_loop/` | redlines, protocol, memory, preflight | 21/21 ✅ |
| `_core/1_governance/invariants/` | redlines | 7/7 ✅ |
| `_core/1_governance/execution_safety/` | redlines | 6/6 ✅ |
| `_core/1_governance/hitl_gates/` | redlines, protocol, memory | 9/9 ✅ |
| `_core/1_governance/edit_accuracy/` | memory | 5/5 ✅ |
| `_core/1_governance/skills_manifest/` | memory | 26/26 ✅ |
| `_core/2_workflows/feature_dev_build/` | redlines, protocol, preflight | 16/16 ✅ |
| `_core/2_workflows/feature_dev_design/` | protocol | 10/10 ✅ |
| `_core/2_workflows/documentation/` | redlines, protocol, memory | 17/17 ✅ |
| `_core/2_workflows/error_triage/` | redlines, protocol | 24/24 ✅ |
| `_core/2_workflows/communication/` | memory | 19/19 ✅ |
| `_core/2_workflows/gitlab_context/` | protocol | 12/12 ✅ |
| `_core/5_commands/review/` | redlines, protocol (+gitlab_context import), preflight | 10/10 ✅ |
| `_core/3_engineering/testing_aaa/` | standards, redlines, protocol, preflight | 15/15 ✅ |
| `_core/3_engineering/code_standards/` | standards, redlines | 9/9 ✅ |
| `_core/3_engineering/code_review/` | protocol, redlines, memory | 6/6 ✅ |
| `_core/3_engineering/security_audit/` | redlines, standards, protocol, preflight, memory | 10/10 ✅ |
| `_core/3_engineering/architecture/` | protocol, standards, redlines, memory | 8/8 ✅ |
| `_core/3_engineering/api_contracts/` | standards | 7/7 ✅ |
| `_core/4_refactoring/smell_detection/` | redlines, standards, protocol | 4/4 ✅ |
| `_core/4_refactoring/extraction_patterns/` | standards | 7/7 ✅ |
| `_core/4_refactoring/refactor_persona/` | protocol, redlines, memory | 3/3 ✅ |
| `_core/5_commands/commit/` | redlines, protocol, memory | ✅ |
| `_core/5_commands/explain/` | protocol | ✅ |
| `_core/5_commands/fix/` | protocol | ✅ |
| `_core/5_commands/test/` | protocol | ✅ |
| `_core/5_commands/security/` | protocol | ✅ |
| `_core/5_commands/refactor/` | protocol | ✅ |

**Shells (rev. 4, applied):** `opencode/agents/build.md` (skeleton), `cursor/rules/agent-core.mdc` (skeleton), `opencode/commands/review.md` (skeleton + `security-reviewer` tail), `cursor/agents/code-reviewer.md` (skeleton + `/security-auditor` tail), `opencode/AGENTS.md` (skeleton, pulled forward), 3 example files (fragment imports).

**Pending:** NONE — all phases complete. Remaining user actions: `./agentc-cli link <ide>`; commit Phases 3–6.
**Never touched:** `dist/`, `agentc/`, `copilot/` (except examples), `opencode/opencode.json` (pre-existing staged MCP bump, not ours).

### Artifact inventory

| Artifact | Path |
|---|---|
| **Session context (handoff — READ FIRST in a new session)** | `docs/context/2026-08-12-refactoring-session-context.md` ✅ |
| Research findings (primary sources, cited) | `docs/research/2026-08-12-agent-prompt-best-practices.md` ✅ |
| This plan (living tracker, rev. 15) | `docs/plans/2026-08-12-high-density-refactor.md` ✅ |
| Phase 0 pilot audit (metrics + 5 full matrices, 91/91) | `docs/refactoring/00-pilot.md` ✅ |
| Phase 1 staging kit (mapping table + 11 files + Appendix A Phase 0.5 rework) | `docs/refactoring/01-governance-workflows-staged.md` ✅ (superseded by application) |
| Phase 1 audit (metrics + parity + contract verification) | `docs/refactoring/01-governance-workflows.md` ✅ (superseded by rev. 4) |
| Rev. 4 fragment rework audit (182/182 parity + dist verification) | `docs/refactoring/02-fragment-rework.md` ✅ |
| Verification audit (dist structure + imports + loss check) | `docs/refactoring/03-verification-audit.md` ✅ |
| Phase 2 audit (9 concepts → 26 fragments, 69/69, dist re-audit) | `docs/refactoring/03-engineering-refactoring.md` ✅ |
| Phase 3 audit (6 command concepts → folders, 12 shells rebuilt) | `docs/refactoring/04-commands.md` ✅ |
| Phase 4 audit (24 skills → own pyramid, all ≤500 lines) | `docs/refactoring/05-skills.md` ✅ |
| Phase 5 audit (11 opencode agents + 2 rules → skeletons) | `docs/refactoring/06-opencode.md` ✅ |
| Phase 6 audit (6 cursor agents + 8 cursor rules → skeletons, FINAL) | `docs/refactoring/07-cursor.md` ✅ |
| Rev. 4 staging kit (25 fragments + 6 shells + deletion list) | `docs/refactoring/02-fragment-rework-staged.md` ✅ (superseded by application) |
| Phase 3–6 audits | `docs/refactoring/04-commands.md`…`06-cursor.md` — future |

---

## 1b. REV. 4 EXECUTION PLAN — Fragment-Based Pyramid Assembly (✅ EXECUTED 2026-08-12 — see `docs/refactoring/02-fragment-rework.md`)

**Staging kit (superseded by application):** `docs/refactoring/02-fragment-rework-staged.md`

### Rules
1. Every concept imported into shells becomes a folder: `<concept>/redlines.md`, `protocol.md`, `standards.md`, `memory.md`, `preflight.md` — only sections the content actually has.
2. Fragments: **no XML tags, no markdown headings** (bold labels only). Fixes both dist issues.
3. Fragments may import same-section-type fragments (root-relative paths, e.g., `review/protocol.md` imports `_core/2_workflows/gitlab_context/protocol.md`); cross-section deps hoisted to shells.
4. Shells: canonical skeleton — each XML tag imports its section's fragments; IDE-specific names stay in shells.
5. Zero-loss: per-concept constraint inventory; count OUT == IN across the concept's fragments.

### Step 1 — Create 25 fragments (13 concept folders)
| Concept folder | Fragments |
|---|---|
| `_core/1_governance/anti_loop/` | redlines, protocol, memory, preflight |
| `_core/1_governance/invariants/` | redlines |
| `_core/1_governance/execution_safety/` | redlines |
| `_core/1_governance/hitl_gates/` | redlines, protocol, memory |
| `_core/1_governance/edit_accuracy/` | memory |
| `_core/1_governance/skills_manifest/` | memory |
| `_core/2_workflows/feature_dev_build/` | redlines, protocol, preflight |
| `_core/2_workflows/feature_dev_design/` | protocol |
| `_core/2_workflows/documentation/` | redlines, protocol, memory |
| `_core/2_workflows/error_triage/` | redlines, protocol |
| `_core/2_workflows/communication/` | memory |
| `_core/2_workflows/gitlab_context/` | protocol |
| `_core/5_commands/review/` | redlines, protocol (+imports gitlab_context/protocol), preflight |

### Step 2 — Rebuild 6 shells with canonical skeletons
1. `opencode/agents/build.md` — redlines (own + feature_dev_build/redlines); protocol (own + feature_dev_build/protocol); standards (testing_aaa.md + code_standards.md — Phase 2 paths, unchanged); memory (own + edit_accuracy/memory); preflight (own + feature_dev_build/preflight)
2. `cursor/rules/agent-core.mdc` — redlines (own + execution_safety/redlines); protocol (own); preflight (own)
3. `opencode/commands/review.md` — redlines (review/redlines); protocol (review/protocol); standards (code_review.md + code_standards.md); preflight (review/preflight) + `security-reviewer` tail
4. `cursor/agents/code-reviewer.md` — same skeleton + `/security-auditor` tail
5. `opencode/AGENTS.md` — memory (skills_manifest/memory); own orchestration+delegation content wrapped in protocol; redlines (hitl_gates/redlines + execution_safety/redlines + anti_loop/redlines); protocol (hitl_gates/protocol + anti_loop/protocol); memory (hitl_gates/memory + anti_loop/memory + communication/memory); preflight (anti_loop/preflight). NOTE: skills manifest moves from top of file into `<formatting_and_memory>` (pyramid position 2) — deliberate structural change, flagged in audit.
6. 3 example files (`opencode/.examples/example_command.md`, `cursor/.examples/example_AGENTS.md`, `cursor/.examples/example_subagent.md`) — anti_loop/execution_safety imports → fragment paths (all 4 anti_loop fragments to preserve example semantics)

### Step 3 — Delete 12 superseded flat files
`_core/1_governance/`: anti_loop.md, invariants.md, execution_safety.md, hitl_gates.md, edit_accuracy.md, skills_manifest.md · `_core/2_workflows/`: feature_dev_build.md, feature_dev_design.md, documentation.md, error_triage.md, communication.md, gitlab_context.md · `_core/5_commands/`: review.md

### Step 4 — Verify
1. `zig build test` → EXIT 0
2. `./agentc-cli build` → SUCCESS
3. dist read-back: **exactly ONE of each XML tag per compiled shell**; zero fragment headings; no cross-IDE contamination; AGENTS.md compiles with all fragments
4. Per-concept parity: constraint count OUT == IN (matrices in staging doc)

### Step 5 — Docs
- Update `docs/refactoring/00-pilot.md` + `01-governance-workflows.md` with rev. 4 rework notes (superseded scheme documented)
- Write `docs/refactoring/02-fragment-rework.md` audit
- Plan → rev. 7 (applied state)

### Phase impact
- Phases 2–6 proceed with the fragment scheme from the start (3_engineering/4_refactoring concepts → folders; skills keep own pyramid — standalone artifacts, not imports)
- `testing_aaa.md`, `code_standards.md`, `code_review.md` remain flat until Phase 2 converts them (import paths in build.md/review shells stay valid meanwhile)

## 2. Objective

Refactor every prompt/rule file into the high-density command-style format: pyramid attention layout with semantic XML isolation (`<red_lines>` → `<execution_protocol>` → [`<standards>`] → `<formatting_and_memory>` → `<pre_flight_check>`), imperative encoding (positive-first, MUST/NEVER reserved for true invariants) — with **100% constraint retention** proven by a per-concept 1:1 audit matrix. Architecture: XML tags live ONLY in host shells; `_core/1~5` = tag-free, heading-free fragments in concept folders; shells import fragments inside matching sections.

## 3. Decision Log (all user decisions, chronological)

1. **Scope:** Phased full rollout — all ~100 files, pilot first (2026-08-12).
2. **Format:** XML tag wrappers inside markdown (2026-08-12).
3. **Artifacts:** per-phase matrices + metrics → `docs/refactoring/` (2026-08-12).
4. **Research:** all 7 findings incorporated → rev. 2 (2026-08-12).
5. **Gate 1:** plan rev. 2 approved → Phase 0 (2026-08-12).
6. **Gate 2:** pilot approved → Phase 1 (2026-08-12).
7. **Import-gap direction:** review `dist/` first, then design extraction of common parts for opencode/cursor/future IDEs (2026-08-12).
8. **Rev. 3:** Compiled-Pyramid Contract adopted + refactor Phase 0 changes (2026-08-12).
9. **Rev. 3.1:** content-driven mapping — `_core/1~4` files refactored per their actual content, NO blanket `<standards>` placement (2026-08-12).
10. **Gate 2.5:** permission granted — "you can start next step" (2026-08-12).
11. **Gate 3.5:** rev. 4 fragment rework approved ("Approve — execute rework") + applied + verified (2026-08-12).
12. **Gate 4:** Phase 2 approved ("approve Phase 2") + applied + verified (2026-08-12).
13. **Gate 5:** Phase 3 approved ("approve to continue next Phase") + applied + verified (2026-08-12).
14. **Gate 6:** Phase 4 approved ("Approve Phase 4") + applied + verified (2026-08-12).
15. **Gate 7:** Phase 5 approved ("approve to Phase 5") + applied + verified (2026-08-12).
16. **Gate 8:** Phase 6 approved ("approve to Phase 6") + applied + verified — **PROJECT COMPLETE** (2026-08-12).

## 4. Compiled-Pyramid Contract (rev. 3 — SUPERSEDED by rev. 4 fragment scheme; kept for history)

Dist review (`dist/opencode/commands/review.md`, `dist/cursor/agents/code-reviewer.md`) revealed: imports compile OUTSIDE the parent's XML pyramid; `_core` imports carry IDE-specific agent names (cross-IDE contamination: `security-reviewer` ships into cursor agents); shell-specific routing lands buried at the end of compiled files. Rev. 3 kept XML inside `_core` files (nested tags) — rev. 4 replaced this: XML lives ONLY in shells; `_core` = tag-free fragments.

1. **Section placement rule:** every `<!-- @import -->` in a host shell sits INSIDE the XML section where the imported content semantically belongs. Compiler inlines at directive position (verified `agentc/core/compiler.zig:55-57`). Compiled output = one coherent pyramid.
2. **Pyramid schema:** `<red_lines>` → `<execution_protocol>` → `<standards>` (rev. 3) → `<formatting_and_memory>` → `<pre_flight_check>`.
3. **Content-driven mapping (rev. 3.1):** each `_core/1–4` file gets its OWN internal pyramid matching its actual content; hosts place imports by the imported file's DOMINANT type. Full mapping table in `docs/refactoring/01-governance-workflows-staged.md` (intro section).
4. **IDE-neutral `_core`:** no IDE-specific agent names in `_core/` imports; host shells supply names (opencode: `security-reviewer`; cursor: `/security-auditor`). Audited as "name parameterized to host shell".
5. **Minimal host shells:** shell = frontmatter + IDE glue + imports in sections + IDE-only tail. Future IDEs = new thin shells over the same `_core/` imports.

## 5. Research-Informed Format Rules (rev. 2)

1. **XML tags: body only.** NEVER in YAML frontmatter (Anthropic skill `name`/`description` ban XML; ≤64 chars / ≤1024 chars; OpenCode name regex `^[a-z0-9]+(-[a-z0-9]+)*$`).
2. **Length budgets (official line/char, not words):** AGENTS.md/global < 200 lines; skill body < 500 lines, description ≤ 1,024 chars (≤ 1,536 combined listing), name ≤ 64; cursor `.mdc` < 500 lines; agent prompts < 200 lines. Word targets (300–500 / 200–400 / 250–450) = secondary heuristics only.
3. **Moderated imperatives:** positive-first; MUST/NEVER for invariants only; negatives targeted w/ reason; never state the same rule twice.
4. **Pyramid refinement:** `<red_lines>` top + `<pre_flight_check>` at end re-anchoring each red line in one line; keep pre-flight lean (Opus 5 over-verification).
5. **Codex 32 KiB AGENTS.md cap** — flag if Codex target added to `agentc`.
6. **Verified safe:** XML in rule bodies across Cursor `.mdc`, Cursor agents, GitHub Copilot, OpenCode, agents.md spec.

## 6. Non-Negotiable Preservation Rules

- **Import chains intact:** imports preserved verbatim; refactor at root source only; never duplicate a rule into a host shell that already receives it via import.
- **Lexical Ban (`_core/` only):** `glob`, `grep`, `Task` tool, `build` subagent, `YAML frontmatter`, `@Codebase`, `.mdc` forbidden.
- **`edit_accuracy/memory.md`:** importable ONLY by write-enabled agents (`build`, `refactor`, `docs`, `build-error-resolver`).
- **OpenCode alignment:** prompt text MUST match YAML permission blocks.
- **Cursor `.mdc` hygiene:** `alwaysApply: false` + globs; `/`-syntax interlocks; no OpenCode mechanics.
- **Frontmatter preserved** byte-identical except density-rewritten descriptions (trigger-accurate, third person, what+when).
- **`dist/` never edited** — verify via rebuild + read.
- **Zero-loss:** every constraint retained; `red_lines`/protocol/formatting/pre-flight placement decided by content, never by convenience.

## 7. Refactoring Procedure (rev. 4 — fragment scheme)

**For `_core/1~5` concepts (imported into shells):**
1. **Trace** — read concept; record importers + imports and compiled role.
2. **Inventory** — numbered constraint list (audit source of truth, count IN).
3. **Split** — classify each constraint by section type (redlines / protocol / standards / memory / preflight); create `<concept>/<section>.md` fragments. Fragments: **no XML tags, no markdown headings** (bold labels); may import same-section-type fragments (root-relative paths).
4. **Sanitize** — Lexical Ban; IDE-neutrality (no IDE-specific agent names); heading-free check.
5. **Update importers** — every shell importing the old file repoints to the fragments it needs, placed inside the matching XML section of the shell's skeleton.
6. **Audit** — per-concept matrix: count OUT == IN across fragments → `docs/refactoring/<phase>.md`.
7. **Verify** — `zig build test`; `./agentc-cli build`; read `dist/`: exactly ONE of each XML tag per shell, zero fragment headings.

**For host shells (opencode/, cursor/):** canonical skeleton — `<red_lines>` → `<execution_protocol>` → `<standards>` → `<formatting_and_memory>` → `<pre_flight_check>`, each section containing shell-own rules + imports of matching fragments; IDE-specific names in shell tails; frontmatter byte-identical.

**For skills (`_core/skills/*/SKILL.md`):** keep own pyramid (standalone artifacts, shipped verbatim, not imported).

## 8. Phases (each ends with HARD-GATE approval)

- **Phase 0/0.5/1 — Pilot + Governance + Workflows:** ✅ DONE under rev-3 scheme, then **reworked to rev-4 fragments** (13 concept folders, 25 fragments, 6 shells, 182/182 parity — `docs/refactoring/02-fragment-rework.md`).
- **Phase 2 — Engineering + Refactoring (9 concepts → folders):** ✅ DONE — 26 fragments, 69/69 parity, 27 importers repointed, `**Process**` labels in commands; audit `docs/refactoring/03-engineering-refactoring.md`.
- **Phase 3 — Commands (6 concepts → folders):** `commit`, `fix`, `security`, `explain`, `refactor`, `test` + rebuild opencode/cursor command shells with skeletons. ⏳ pending — Gate 5.
- **Phase 3 — Commands (6 concepts → folders):** `commit`, `fix`, `security`, `explain`, `refactor`, `test` + their opencode/cursor command shells.
- **Phase 4 — Skills (24 remaining):** Tier A (>500w): code-review done, rest-api, graphql, writing-for-agents, diagnosing-bugs, zig, receiving-code-review, git, brainstorming, subagent-driven-dev; Tier B (250–500w): aws, writing-plans, verification-gate, domain-modeling, tdd, angular, csharp; Tier C: privacy-guard, react, research, workflow-env, go, rust, nx-monorepo. Skills keep own pyramid (standalone).
- **Phase 5 — OpenCode shells (17 files):** agents ×11 (+build done), rules ×2, commands ×8 (AGENTS.md done in rev. 4). Skeleton treatment.
- **Phase 6 — Cursor shells (22 files):** agents ×7, rules ×8 (+agent-core done), commands ×7. Skeleton treatment.

## 9. Verification (every phase)

1. `zig build test` → pass (no import/frontmatter breakage)
2. `./agentc-cli build` → success (104 files)
3. Read-preview key `dist/` outputs: imports nested inside XML sections; no cross-IDE contamination
4. Audit matrix: count OUT == count IN per file
5. Line-budget check per file (Rule 5.2); over-budget flagged with rationale
6. XML-frontmatter check: no tags in YAML; skill descriptions ≤ 1,024 chars

## 10. Risks & Mitigations

| Risk | Mitigation |
|---|---|
| Semantic drift in subtle constraints | Per-file inventory + 1:1 matrix; code-reviewer gate; dist read-back |
| XML breaks Cursor `.mdc` | Pilot validated; frontmatter stays valid YAML |
| Import blast radius | Full rebuild per phase; imports move but stay verbatim |
| Budget vs zero-loss conflict (architecture.md 1,183w) | Budget is target not cap; surface conflicts, never weaken |
| Skill description rewrite breaks loading | Trigger-accurate third-person what+when; flagged in matrix |
| Over-verification on newer models | MUST/NEVER for invariants; lean pre-flight |
| **Stale import paths after folder conversion** | Post-conversion sweep: explore search for old paths; repoint all importers in same pass (proven in rev. 4 — 23 references fixed) |
| **Fragment heading pollution** | Fragments banned from markdown headings (bold labels only) — verified in dist read-back |
| **Duplicate/nested XML** | XML only in shells — one tag pair per section per shell (verified) |
| Codex 32 KiB cap if target added | Noted; revisit under extensibility protocol |

## 11. HITL Gates & Resume Instructions

- ✅ Gates 1, 2, 2.5, 3.5, 4, 5, 6, 7, 8 — ALL PASSED. **PROJECT COMPLETE.**
- **Remaining user actions:** run `./agentc-cli link <ide>` to symlink compiled output; commit the Phase 3–6 changes (commit message + checkpoint 3 available on request).
- After final phase: remind user to run `./agentc-cli build` and `./agentc-cli link <ide>`.
---

## rev. 27 — 2026-08-15: Wording-optimization session COMPLETE (successor task)

The wording-optimization session (spec/plans under `docs/specs/2026-08-15-*`, audits `docs/refactoring/10-14`) is complete and verified:
- All 5 over-budget files ≤200 lines (build 190, code-reviewer 160, review 153, architect 195/185) — no lazy-load, zero constraints lost.
- Compiled output reduced 5202 → 4271 lines (−17.9%); skills ≤442/500.
- 7 contradiction classes fixed; 44 verified research findings recorded; authoring guide created (`docs/guides/2026-08-15-prompt-authoring-guide.md`).
- Work uncommitted on `main` (user choice). Archive: `docs/context/2026-08-15-wording-optimization-handoff.md`.
- This tracker is now superseded for future work by the archive doc + the new guide.
