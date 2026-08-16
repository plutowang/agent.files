# Refactoring Phase 0 — Pilot Audit Report

**Date:** 2026-08-12
**Plan:** `docs/plans/2026-08-12-high-density-refactor.md` (rev. 2)
**Research basis:** `docs/research/2026-08-12-agent-prompt-best-practices.md`

## Compression Metrics

| File | Words before | Words after | Δ words | Lines before | Lines after | Δ lines | Budget (lines) | Budget status |
|---|---|---|---|---|---|---|---|---|
| `_core/1_governance/anti_loop.md` | 457 | 484 | +5.9% | 37 | 36 | −2.7% | <200 | ✅ 36/200 |
| `opencode/agents/build.md` | 791 | 800 | +1.1% | 100 | 89 | −11% | <200 | ✅ 89/200 |
| `_core/skills/code-review/SKILL.md` | 1,558 | 1,448 | −7.1% | 330 | 169 | −48.8% | <500 | ✅ 169/500 |
| `_core/5_commands/review.md` | 377 | 412 | +9.3% | 79 | 87 | +10.1% | <200 | ✅ 87/200 |
| `cursor/rules/agent-core.mdc` | 347 | 384 | +10.7% | 31 | 40 | +29% | <500 | ✅ 40/500 |
| **Total** | **3,530** | **3,528** | **−0.1%** | **577** | **421** | **−27%** | | |

### Honest assessment

- **Token delta ≈ ±0–10%.** Zero-loss preservation caps token reduction at prose-tightening; the XML tag pairs and `<pre_flight_check>` anchors add ~30–40 words per file. The pilot files were already dense product-quality content.
- **Line-density win is real**: −27% total lines; SKILL.md −49% (330 → 169 lines, well under the 500-line skill cap).
- **Structural gains (primary deliverable):** pyramid attention ordering (red lines → protocol → formatting → pre-flight), semantic XML isolation, imperative encoding, red-line re-anchoring at end (research finding: instructions best recalled at prompt end — Anthropic long-context post).
- **Word budgets retained as secondary heuristics only** (rev. 2 decision): original 300–500 / 200–400 / 250–450 targets were not official; vendor line/char budgets used instead.

## Format Validation Points

1. **XML-in-.mdc** (agent-core.mdc): frontmatter (`description`, `alwaysApply`) byte-identical; body accepts free-form markdown — Cursor docs impose no HTML stripping. ✅
2. **Frontmatter untouched** in all 5 files (build.md permission block, SKILL.md name/description/license, agent-core.mdc) — permission alignment and trigger accuracy preserved. ✅
3. **Imports byte-identical**: build.md 4 imports, review.md 3 imports, agent-core.mdc 1 import — all preserved verbatim at original positions. ✅
4. **Lexical Ban** (`_core/` files only): no `glob`, `grep`, `Task` tool, `build` subagent, `YAML frontmatter`, `@Codebase`, `.mdc` introduced. ✅
5. **Permission alignment** (build.md): prompt references only subagents allowed in YAML `task` block (explore, code-reviewer, security-reviewer, refactor, docs, build-error-resolver, verifier); no glob/grep/webfetch instructions. ✅
6. **Cursor hygiene** (agent-core.mdc): `/`-syntax interlocks retained; no OpenCode-specific mechanics introduced. ✅
7. **No XML tags in frontmatter** (skill name/description ban honored). ✅

---

## File 1: `_core/1_governance/anti_loop.md` — Audit Matrix (21 constraints + pre-flight)

| # | Original constraint | New location | Status |
|---|---|---|---|
| 1 | Never execute same tool + same args more than once | `<red_lines>` → bullet 1 | 100% Preserved |
| 2 | Before any retry, state (1) error, (2) approach change | `<execution_protocol>` → bullet 1 | 100% Preserved |
| 3 | Escalation is total order; 2 consecutive failures end attempt; 1 specialist delegation only for build/test failures; then BLOCKED + ask; never restart chain | `<execution_protocol>` → bullet 2 | 100% Preserved |
| 4 | Anti-patterns: retry nonexistent read, re-run same bash, re-apply rejected edit, re-run failing test unchanged | `<red_lines>` → bullet 2 | 100% Preserved |
| 5 | Verify new information before continuing to write | `<execution_protocol>` → bullet 3 | 100% Preserved |
| 6 | Similar content detected → STOP immediately, summarize and end | `<red_lines>` → bullet 3 | 100% Preserved |
| 7 | Responses concise and structured; bullets/tables over prose | `<execution_protocol>` → bullet 4 | 100% Preserved |
| 8 | Never >150 lines continuous text without tool call/checkpoint | `<red_lines>` → bullet 5 | 100% Preserved |
| 9 | Errors/analysis stated ONCE, never rephrased | `<execution_protocol>` → bullet 5 | 100% Preserved |
| 10 | 3+ repeated reasoning steps without tool call = thinking loop | `<red_lines>` → bullet 4 | 100% Preserved |
| 11 | STOP deliberating; execute first safe action | `<red_lines>` → bullet 4 | 100% Preserved |
| 12 | Thinking loops are wasteful | `<execution_protocol>` → bullet 6 | 100% Preserved |
| 13 | Ambiguity → prefer action over deliberation; read-only tool available → use it | `<execution_protocol>` → bullet 7 | 100% Preserved |
| 14 | Read-only commands ALWAYS safe; do not second-guess | `<execution_protocol>` → bullet 8 | 100% Preserved |
| 15 | Context window is finite, non-renewable | `<formatting_and_memory>` → bullet 1 | 100% Preserved |
| 16 | Targeted retrieval; locate first, read only what's needed | `<formatting_and_memory>` → bullet 2 | 100% Preserved |
| 17 | Batch independent calls; never serialize parallel work | `<formatting_and_memory>` → bullet 3 | 100% Preserved |
| 18 | Skip preambles, restatements, filler | `<formatting_and_memory>` → bullet 4 | 100% Preserved |
| 19 | Never re-read just-written files; exception: critical edits (signatures/APIs/imports) | `<formatting_and_memory>` → bullet 5 | 100% Preserved |
| 20 | Distill/prune stale tool outputs | `<formatting_and_memory>` → bullet 6 | 100% Preserved |
| 21 | Compact early rather than late; summarize when context pressure high | `<formatting_and_memory>` → bullet 7 | 100% Preserved |
| — | *(added)* Pre-flight echo of red lines (approved rev. 2, research finding: end-anchoring) | `<pre_flight_check>` | Intentional addition |

## File 2: `opencode/agents/build.md` — Audit Matrix (24 constraints + 4 imports)

| # | Original constraint | New location | Status |
|---|---|---|---|
| 1 | Identity: implementation agent; execute plan step by step | Intro (line 1) | 100% Preserved |
| 2 | Core rule: execute exactly what plan specifies; no reinterpret/scope/redesign; surface wrong plan and stop | `<red_lines>` → bullet 1 | 100% Preserved |
| 3 | Review plan; Todo list = strict blueprint; exact paths/architectures/logic; ask before guessing when ambiguous/blocked | `<execution_protocol>` → step 1 | 100% Preserved |
| 4 | Work incrementally; one step at a time; todos in_progress → completed | `<execution_protocol>` → step 2 | 100% Preserved |
| 5 | Verify continuously after each meaningful change | `<execution_protocol>` → step 3 | 100% Preserved |
| 6 | Report progress template (Status/Changes/Verify/Blockers) | `<execution_protocol>` → step 4 | 100% Preserved |
| 7 | Load workflow-env skill before build/test/lint commands | `<formatting_and_memory>` → bullet 1 | 100% Preserved |
| 8 | Read existing code before editing | `<formatting_and_memory>` → bullet 2 | 100% Preserved |
| 9 | Targeted edits; never rewrite whole files unless asked | `<red_lines>` → bullet 7 | 100% Preserved |
| 10 | Preserve code style: indentation, naming, import ordering | `<formatting_and_memory>` → bullet 3 | 100% Preserved |
| 11 | Handle all error cases; no bare throws, no swallowed errors | `<red_lines>` → bullet 4 | 100% Preserved |
| 12 | No new dependencies without user approval | `<red_lines>` → bullet 5 | 100% Preserved |
| 13 | No drive-by refactors | `<red_lines>` → bullet 6 | 100% Preserved |
| 14 | Messy/complex code → delegate `refactor` for plan; test-first discipline; test break = stop and report; report to user before delegating | `<execution_protocol>` → step 5 | 100% Preserved |
| 15 | Verify imports updated after adding references (most common build failure) | `<formatting_and_memory>` → bullet 4 | 100% Preserved |
| 16 | Run test suite after all changes; fix failures before done | `<formatting_and_memory>` → bullet 5 | 100% Preserved |
| 17 | NEVER npm; use pnpm | `<red_lines>` → bullet 2 | 100% Preserved |
| 18 | Post-build delegation: >3 files → code-reviewer; auth/crypto/secrets/validation → security-reviewer; significant feature → docs; complex → verifier | `<execution_protocol>` → step 6 | 100% Preserved |
| 19 | Delegation context: summary + files with complete contents + intent; explore pre-reads; context-only subagents work from parent context | `<formatting_and_memory>` → bullet 6 | 100% Preserved |
| 20 | Subagent report → present summary, ask user; no self-re-evaluation, no auto-apply | `<formatting_and_memory>` → bullet 7 | 100% Preserved |
| 21 | verification-gate = own self-gate, never optional; verifier = separate independent second opinion | `<pre_flight_check>` | 100% Preserved |
| 22 | Branch finishing: present options (merge/PR/keep working); state branch, changes, test status; let user choose | `<execution_protocol>` → step 7 | 100% Preserved |
| 23 | Complex task orchestration: Plan→Build→Review→Commit chain; plan approved first; max 2 review iterations | `<execution_protocol>` → step 8 | 100% Preserved |
| 24 | Never commit, merge, or push without explicit user approval (Invariant II) | `<red_lines>` → bullet 3 | 100% Preserved |
| 25–28 | 4 imports (feature_dev_build, testing_aaa, code_standards, edit_accuracy) | End of file, verbatim | 100% Preserved |

## File 3: `_core/skills/code-review/SKILL.md` — Audit Matrix (27 constraint groups + frontmatter)

| # | Original constraint | New location | Status |
|---|---|---|---|
| 1 | Activation triggers (review/critique/analyze; BRANCH-NAME; snippet/function/file; PR/MR; pre-merge; quality; security/perf; diffs) | `<execution_protocol>` → paragraph 1 | 100% Preserved |
| 2 | Three review modes (snippet / current branch default / other branch) with mode rules | `<execution_protocol>` → Three review modes | 100% Preserved |
| 3 | Snippet focus: security/perf/types/logic | `<execution_protocol>` → Snippet mode focus | 100% Preserved |
| 4 | Finding tiers: 🔴 Critical / 🟡 Warning / 🟢 Suggestion with definitions | `<execution_protocol>` → Finding tiers | 100% Preserved |
| 5 | Finding format: file:line, question framing, corrected example only if requested | `<execution_protocol>` + `<red_lines>` bullet 4 | 100% Preserved |
| 6 | Snippet mode never reviews full branch | `<red_lines>` → bullet 2 | 100% Preserved |
| 7 | Branch provided → git-worktrees skill; fetch/create/review/cleanup | `<execution_protocol>` → Branch selection | 100% Preserved |
| 8 | No branch → uncommitted (staged `git diff --cached`; unstaged `git diff`); automated checks; no worktree/switch | `<execution_protocol>` + `<red_lines>` bullet 8 | 100% Preserved |
| 9 | Analyze branch context (5 items incl. merge-base isolation) | `<execution_protocol>` → Analyze branch context | 100% Preserved |
| 10 | Default branch detection script (verbatim) | `<execution_protocol>` → code block | 100% Preserved |
| 11 | MUST use git merge-base; rationale; apply to log/diff/stat/name-status | `<execution_protocol>` → Finding branch-specific changes | 100% Preserved |
| 12 | Uncommitted changes commands (4) | `<execution_protocol>` → code block | 100% Preserved |
| 13 | Lock file exclusion (13 files listed) | `<red_lines>` → bullet 1 | 100% Preserved |
| 14 | Large diff confirmation (>100 files or >5000 lines) | `<red_lines>` → bullet 6 | 100% Preserved |
| 15 | Checks: current branch always; worktree ask first; gtimeout/timeout 5-min limit; failures don't stop review | `<execution_protocol>` + `<red_lines>` bullet 7 | 100% Preserved |
| 16 | Project type detection script (verbatim) | `<execution_protocol>` → code block | 100% Preserved |
| 17 | Checks by type (nx/rust/go/node + npm/yarn fallback) (verbatim) | `<execution_protocol>` → code block | 100% Preserved |
| 18 | Capture output into report | `<execution_protocol>` → after checks | 100% Preserved |
| 19 | Review only THIS branch's changes (merge-base) | `<red_lines>` → bullet 3 | 100% Preserved |
| 20 | Change analysis (per-file diff, cached/unstaged, git show, patterns, consistency) | `<execution_protocol>` → 1. Change Analysis | 100% Preserved |
| 21 | Code quality (style, naming, organization, DRY, abstraction) | `<execution_protocol>` → 2. Code Quality | 100% Preserved |
| 22 | Technical review (correctness, error handling, performance, security, resources, concurrency) | `<execution_protocol>` → 3. Technical Review | 100% Preserved |
| 23 | Best practices (patterns, SOLID, testing, docs, API consistency, backwards compat) | `<execution_protocol>` → 4. Best Practices | 100% Preserved |
| 24 | Dependencies/integration (new deps, breaking changes, impact, migrations) | `<execution_protocol>` → 5. Dependencies | 100% Preserved |
| 25 | Report structure (10 sections) | `<formatting_and_memory>` | 100% Preserved |
| 26 | Report output: display markdown + save CODE_REVIEW_[date].md in repo root | `<formatting_and_memory>` → Report output | 100% Preserved |
| 27 | User interaction: display report, actionable next steps, prominent criticals | `<pre_flight_check>` (final clause) | 100% Preserved |
| 28 | Feedback style: questions not directives; ❌/✅ examples; 4 reasons | `<execution_protocol>` → Feedback style | 100% Preserved |
| — | Frontmatter (name, description, license) | Byte-identical | 100% Preserved |

## File 4: `_core/5_commands/review.md` — Audit Matrix (10 constraints + 3 imports)

| # | Original constraint | New location | Status |
|---|---|---|---|
| 1 | HARD GUARDRAIL: NEVER modify/create/delete files; read-only; report never patches | `<red_lines>` → bullet 1 | 100% Preserved |
| 2 | Step 1: `/review against <branch>` → use as base; `/review` → auto-detect (script) + main fallback | `<execution_protocol>` → Step 1 | 100% Preserved |
| 3 | Step 2: GitLab + MCP → load gitlab_context.md; fetch MR, linked issues, blocked/blocking, epics; requirements block or none | `<execution_protocol>` → Step 2 | 100% Preserved |
| 4 | Otherwise: ask "Paste requirements or skip (code-only review)?"; pasted → use; skipped → proceed | `<execution_protocol>` → Step 2 | 100% Preserved |
| 5 | Step 3: merge-base diff commands; include uncommitted (cached + unstaged) | `<execution_protocol>` → Step 3 | 100% Preserved |
| 6 | Step 4: load code-review skill; two axes per engineering standard | `<execution_protocol>` → Step 4 | 100% Preserved |
| 7 | Axis 1 Standards delegated to skill; do not restate | `<execution_protocol>` → Axis 1 | 100% Preserved |
| 8 | Axis 2 Spec: implementation check w/ quote+cite, missing/partial, scope creep, dependencies, follow-ups, issue-line quotes | `<execution_protocol>` → Axis 2 | 100% Preserved |
| 9 | Requirements unavailable → Standards axis only | `<execution_protocol>` → Step 4 tail | 100% Preserved |
| 10 | Step 5: severity categories w/ file:line; security → security-reviewer; verdict Approved/Approved with suggestions/Changes requested | `<execution_protocol>` → Step 5 | 100% Preserved |
| 11–13 | 3 imports (gitlab_context, code_review, code_standards) | End of file, verbatim | 100% Preserved |

## File 5: `cursor/rules/agent-core.mdc` — Audit Matrix (8 constraints + 1 import)

| # | Original constraint | New location | Status |
|---|---|---|---|
| 1 | Primary Orchestrator in production-grade multi-agent environment | Intro | 100% Preserved |
| 2 | MUST delegate via exact slash commands when triggers met; never perform specialized tasks yourself | `<red_lines>` bullet 1 + `<execution_protocol>` | 100% Preserved |
| 3 | Trigger table (verifier/code-reviewer/security-auditor/debugger/architect/refactor) | `<execution_protocol>` → table | 100% Preserved |
| 4 | Concise factual context when invoking; no verbose `<thought>` blocks before delegation | `<red_lines>` bullet 5 + `<execution_protocol>` | 100% Preserved |
| 5 | Fail Twice Rule: 2 consecutive failures → STOP | `<red_lines>` → bullet 2 | 100% Preserved |
| 6 | Delegate once to specialist; specialist fails → BLOCKED bold + ask user; never blindly retry a third time | `<red_lines>` bullet 3 + `<execution_protocol>` → Fail Escalation | 100% Preserved |
| 7 | No drive-by edits; adjacent refactor only when instructed/delegated to `/refactor` | `<red_lines>` → bullet 4 | 100% Preserved |
| 8 | Action over prose: read-only commands (git status, ls, cat) executed immediately | `<execution_protocol>` → Action over Prose | 100% Preserved |
| — | Import execution_safety.md | Kept in place, verbatim | 100% Preserved |
| — | Frontmatter (description, alwaysApply) | Byte-identical | 100% Preserved |

---

## Constraint Parity Summary

| File | Constraints IN (original) | Constraints OUT (refactored) | Parity |
|---|---|---|---|
| anti_loop.md | 21 | 21 (+1 pre-flight echo, approved) | ✅ 1:1 |
| build.md | 24 | 24 (+4 imports) | ✅ 1:1 |
| SKILL.md | 28 | 28 (+frontmatter) | ✅ 1:1 |
| review.md | 10 | 10 (+3 imports) | ✅ 1:1 |
| agent-core.mdc | 8 | 8 (+1 import) | ✅ 1:1 |
| **Total** | **91** | **91** | **✅ 100%** |

## Open Items / Notes for Phase 1+

1. **Compression ceiling**: zero-loss caps token reduction; expect ±10% word delta across all phases. The durable wins are structure, ordering, and line density.
2. **`_core/5_commands/review.md` → cursor code-reviewer agent**: the spec-axis step references `security-reviewer` (opencode subagent). Pre-existing; Cursor shell maps it via its own agent file. Flagged, not changed (zero-assumption rule).
3. **Skill reference-file extraction** (Anthropic progressive disclosure) deferred to Phase 4 — SKILL.md is at 169/500 lines; not needed now.
4. `<pre_flight_check>` sections add ~30 words per file — cost accepted per rev. 2 decision (end-anchoring research finding).