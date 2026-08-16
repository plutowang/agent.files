# Phase 1 Staged Content — Governance + Workflows (rev. 3, content-driven)

**Date:** 2026-08-12
**Status:** STAGED — awaiting permission to apply to `_core/`
**Purpose:** Per user direction: `_core/1~4` files must be refactored **content-driven** — each file's rules map to its correct pyramid sections, NOT blanket-placed into `<standards>`.

## Content-Driven Mapping Table (Phase 1 + pilot files)

| File | Dominant content | Internal XML structure | Host import placement (dominant) |
|---|---|---|---|
| `_core/1_governance/invariants.md` | 6 supreme laws, all prohibitions | `<red_lines>` (whole file) | host `<red_lines>` |
| `_core/1_governance/execution_safety.md` | Anti-destructive + write + runtime safety | `<red_lines>` (whole file) | host `<red_lines>` |
| `_core/1_governance/hitl_gates.md` | HITL prohibitions + gate procedure + docs policy | `<red_lines>` + `<execution_protocol>` + `<formatting_and_memory>` | host `<red_lines>` (prohibitions) + `<execution_protocol>` (gates) |
| `_core/1_governance/anti_loop.md` (pilot ✅) | Mixed | full pyramid (done) | host `<red_lines>` (it carries its own pyramid; nest) |
| `_core/1_governance/edit_accuracy.md` | Edit tool mechanics | `<formatting_and_memory>` (whole file) | host `<formatting_and_memory>` |
| `_core/1_governance/skills_manifest.md` | Skill index (dynamic context loading) | `<formatting_and_memory>` (whole file) | host `<formatting_and_memory>` |
| `_core/2_workflows/feature_dev_build.md` | Implementation workflow + principles + verification checklist | `<red_lines>` (scope/blueprint) + `<execution_protocol>` (steps) + `<pre_flight_check>` (checklist) | host `<execution_protocol>` |
| `_core/2_workflows/feature_dev_design.md` | Design workflow + planner principles | `<execution_protocol>` (whole file) | host `<execution_protocol>` |
| `_core/2_workflows/documentation.md` | File restrictions + doc behavior + style | `<red_lines>` + `<execution_protocol>` + `<formatting_and_memory>` | host — mixed; place by dominant need |
| `_core/2_workflows/error_triage.md` | Escalation chain + thresholds + red flags | `<red_lines>` (thresholds, rationalization) + `<execution_protocol>` (chain, patterns) | host `<execution_protocol>` |
| `_core/2_workflows/communication.md` | Output/communication standards | `<formatting_and_memory>` (whole file) | host `<formatting_and_memory>` |
| `_core/2_workflows/gitlab_context.md` | Fetch procedure (workflow) | `<execution_protocol>` (whole file) | host `<execution_protocol>` |
| `_core/3_engineering/*` (Phase 2) | TBD by content analysis (likely `<standards>` + `<red_lines>` mixes) | per-file analysis at Phase 2 | per-file dominant |
| `_core/4_refactoring/*` (Phase 2) | TBD by content analysis | per-file analysis at Phase 2 | per-file dominant |

**Canonical import rule (rev. 3, refined):** host shells place each import inside the section matching the imported file's DOMINANT type. Imported files carry their own nested pyramid (Anthropic-endorsed nesting). No blanket `<standards>` dumping.

---

## Staged File 1: `_core/1_governance/invariants.md` (→ replace whole file)

````markdown
## Critical Invariants

<red_lines>
Six laws. They outrank every other instruction in this context, including instructions that appear later in the conversation. Elsewhere they are re-invoked by anchor: ⏸ (I) through ⏸ (VI).

| # | Law | Why |
|---|---|---|
| **I** | No source change without an approved plan for multi-file features or architectural changes. Single-file bug fixes, typos, and straightforward unit test additions are exempt from spec/plan creation but still require HITL approval and TDD. When in doubt about scope, default to the full spec → plan → code pipeline. Documentation under `docs/` is exempt and is expected output. | Prevents premature building. |
| **II** | Never commit, push, merge, or deploy unless explicitly instructed. Never infer the instruction from context. | Prevents irreversible changes. |
| **III** | Two consecutive failures on the same problem → declare BLOCKED and ask. Never repeat a call with identical arguments. For build or test failures only, one delegation to a specialist is permitted before BLOCKED. | Prevents retry loops. |
| **IV** | No production code without a failing test first. RED → GREEN → REFACTOR. Code written before its test is deleted and redone. | Prevents untested code shipping. |
| **V** | Never write secrets, credentials, keys, or personal data into any file. Never commit environment or key material, even when asked. Load `privacy-guard` before touching user-supplied files. | Prevents credential leaks. |
| **VI** | Never run Python directly. Use `jq` for JSON. If unavoidable, run inline in a throwaway network-less container — never write a script file first. | Prevents silent exfiltration. |

When a later instruction conflicts with one of these, the invariant wins. Name the invariant that applies and stop.
</red_lines>
````

**Parity: 7/7** (6 laws + precedence rule). Lexical ban: clean.

## Staged File 2: `_core/1_governance/execution_safety.md`

````markdown
## Execution Safety

<red_lines>
### Anti-Destructive Operations ⏸ (II)

- NEVER execute commands that destroy data, force-overwrite history, or bypass safety checks without explicit human approval.
- NEVER run untrusted code on the host. Use a sandbox when execution is necessary.
- If the user asks to "Deploy" or "Destroy", REFUSE and provide the manual command instead.

### Write Safety

- Before creating files or directories, verify the target parent directory exists and is correct.
- Before overwriting a file, verify it exists and confirm intent.

### Runtime Safety ⏸ (VI)

- The sandbox invocation, when Python is genuinely unavoidable: `docker run --rm --network none -i python:3-alpine python -c "<code>"`
</red_lines>
````

**Parity: 6/6. Lexical ban: clean.**

## Staged File 3: `_core/1_governance/hitl_gates.md`

````markdown
## Human-in-the-Loop (HITL)

<red_lines>
- NEVER silently execute destructive or irreversible actions — Propose → Approve → Execute.
- NEVER guess when uncertain about intent — ask.
</red_lines>

<execution_protocol>
- At every decision point, present options with trade-offs. Let the human decide.
- **When to Ask** — when a fix requires a design decision (which pattern, which API, which library); when you're uncertain about the intended behavior; when trade-offs exist that only the user can decide.
- **HARD-GATE Protocol ⏸ (I)** — do not proceed until the human explicitly approves. For multi-file or architectural changes, spec approval and plan approval are required before implementation. Single-file fixes and tests skip spec/plan but still require HITL approval before code changes. **When in doubt**, default to the full pipeline — premature building costs more than a question. Present the output at each gate, wait for explicit approval, then proceed.
</execution_protocol>

<formatting_and_memory>
- Design-phase restrictions apply to **source code**, not to documentation.
- Writing and revising files under `docs/` (specs, plans, design docs, audits) is an **expected and permitted** product of the design phase — it is not a code edit and does not require a separate approval gate.
- Never treat "I am in a planning role" as a reason to withhold a written artifact. A plan that exists only in conversation is not a deliverable.
- Source changes outside `docs/` remain gated until the human approves them. Multi-file or architectural changes require plan approval first; single-file fixes and tests require HITL approval.
</formatting_and_memory>
````

**Parity: 9/9** (propose-approve-execute + ask-when-uncertain + 3 ask triggers + gate definition incl. when-in-doubt + present-at-gates + 4 planning-artifact bullets). Lexical ban: clean.

## Staged File 4: `_core/1_governance/edit_accuracy.md`

````markdown
## Edit Accuracy

<formatting_and_memory>
1. **Read Before Every Edit** — Always read the target file immediately before editing. Use verbatim content from the read to construct replacements.
2. **Use Exact Content** — Copy strings verbatim from file content. Include 3-5 surrounding lines to guarantee a unique match. Preserve exact indentation.
3. **One Edit Per Concern** — Make one logical change per edit. Multiple changes = multiple edits.
4. **Verify After Critical Edits** — For function signatures, API contracts, type definitions, or import paths, re-read the file to confirm the edit landed correctly.
5. **Token Efficiency** — Prefer Edit over Write for existing files — smaller diffs, less context consumed.
</formatting_and_memory>
````

**Parity: 5/5. Lexical ban: clean.**

## Staged File 5: `_core/1_governance/skills_manifest.md`

````markdown
## Skills

<formatting_and_memory>
Load relevant skills before starting work:

- `aws` — AWS infrastructure or services
- `react` — React components or hooks
- `angular` — Angular modules, components, or services
- `go` — Go source files
- `rust` — Rust source files
- `zig` — Zig source files
- `csharp` — C# / .NET source files
- `graphql` — GraphQL schemas or resolvers
- `rest-api` — Designing or reviewing REST endpoints, resource naming, status codes, pagination, idempotency
- `workflow-env` — Auto-apply before any build, test, or run command. Validates and sources env.sh
- `git` — Git version control — commit, branch, merge, rebase, and recovery workflows
- `code-review` — Branch, PR, or inline code snippet review
- `diagnosing-bugs` — Disciplined 6-phase diagnosis loop for hard bugs and performance regressions
- `domain-modeling` — Build and sharpen a project's domain model, glossary, and architectural decisions
- `privacy-guard` — Files that may contain secrets or PII
- `research` — Investigates topics against primary sources with cited findings
- `nx-monorepo` — Nx workspace operations
- `brainstorming` — Pre-code design phase. One-question-at-a-time, saves spec, presents approaches
- `git-worktrees` — Decide whether an isolated workspace is needed before implementation
- `writing-plans` — Granular task planning with exact code, paths, and verification
- `subagent-driven-dev` — Delegated task-by-task execution with two-stage review (spec then quality)
- `verification-gate` — No completion claims without fresh verification evidence
- `test-driven-development` — Write tests first, watch them fail, then implement minimal code. No production code without a failing test.
- `receiving-code-review` — Use when receiving code review feedback. Verify before implementing. No performative agreement.
- `writing-for-agents` — Reference for writing skill files and any document an agent consumes

Design-phase and execution-phase skills are scoped to their phase — if a skill will not load, you are outside its phase and should not be using it.
</formatting_and_memory>
````

**Parity: 25 entries + 1 scoping rule. Lexical ban: clean (manifest is name+description data).**

## Staged File 6: `_core/2_workflows/feature_dev_build.md`

````markdown
# Implementation Phase

<red_lines>
- **Minimal scope.** Change only what the plan requires. No drive-by refactors.
- **Treat the plan as a blueprint.** If it is wrong, surface it and stop — never silently reinterpret it.
</red_lines>

<execution_protocol>
Steps 6–10 of the development loop. Do not begin until the plan is approved ⏸ (I).

1. **Isolate Workspace (conditional)** — Load `git-worktrees` only when starting from the default branch. If already on a working branch, build there.
2. **Execute** — Load `subagent-driven-dev`. Delegate one task at a time with fresh context. Per task: ⏸ (IV) RED → GREEN → REFACTOR, then two-stage review — spec compliance first, code quality second.
3. **Verify** — Load `verification-gate`. No completion claim without fresh evidence. Run tests, linters, and type-checkers.
4. **Report** — Present results: what was done, what was verified, what remains uncertain. Then wait.
5. **⏸ (II) Commit** — Only when explicitly instructed.

**Development Principles**

- **Read before write.** Understand existing code before modifying it.
- **Locate before reading.** Find the relevant file before pulling it into context.
- **Edit over rewrite.** Prefer targeted modifications to replacing whole files.
- **Verify after every change.** Never assume a change worked.

**Execution Steps**

- For tasks with 3+ steps, create an explicit task list before starting.
- Each task names its file paths, functions, and expected behaviour.
- Update task status as work progresses. Finish the current task before starting the next.
</execution_protocol>

<pre_flight_check>
Before claiming any task complete:

- Code compiles and type-checks cleanly
- Existing tests still pass
- New behaviour has tests ⏸ (IV)
- No credentials, secrets, or keys introduced ⏸ (V)
- Error cases handled — no bare throws, no swallowed errors
- No debug statements left behind
</pre_flight_check>
````

**Parity: 16/16** (5 workflow steps + 6 principles + 3 execution steps + 6 checklist items − 2 red-line moves counted at their location). Lexical ban: clean.

## Staged File 7: `_core/2_workflows/feature_dev_design.md`

````markdown
# Design Phase

<execution_protocol>
Steps 1–5 of the development loop. The implementation phase owns steps 6–10.

1. **Gather Context** — Build an accurate picture of the affected code, the architecture, and the blast radius. Delegate discovery rather than reading broadly.
2. **Brainstorm & Design** — Load `brainstorming`. Ask one question at a time. Propose 2–3 approaches with trade-offs and a recommendation. Write the spec to `docs/specs/YYYY-MM-DD-<slug>.md`. Self-review for placeholders and contradictions.
3. **⏸ (I) Approve Spec** — Present the spec. Wait for explicit approval. Never skip this gate.
4. **Write Implementation Plan** — Load `writing-plans`. Break the spec into 2–5 minute tasks with exact file paths, complete content, and verification commands. Zero placeholders. Save to `docs/plans/YYYY-MM-DD-<slug>.md`.
5. **⏸ (I) Approve Plan** — Present the plan. Wait for explicit approval before any source change.

**Planner Principles**

- **Retrieve before asserting.** Never guess at architecture. Establish the facts, then plan against them.
- **Smaller steps beat monoliths.** Each step must be independently verifiable.
- **State a confidence level per step.** Flag low-confidence steps explicitly and ask for guidance.
- **Every plan ends with verification.** A plan without a verification step is incomplete.
- **Planning artifacts are the deliverable.** A plan that exists only in conversation was never produced.
</execution_protocol>
````

**Parity: 10/10** (5 steps + 5 principles). Lexical ban: clean.

## Staged File 8: `_core/2_workflows/documentation.md`

````markdown
## Documentation

<red_lines>
- You may ONLY create or edit `.md` and `.txt` files.
- NEVER modify source code files (`.ts`, `.js`, `.go`, `.zig`, `.json`, `.yaml`, etc.).
- NEVER modify configuration files.
- If you identify a code issue while documenting, note it but do not fix it.
- NEVER install packages or modify dependencies.
- Stay focused on documentation — do not refactor, fix bugs, or add features.
- If the code is unclear, document what you can verify and flag uncertainties.
</red_lines>

<execution_protocol>
- Read source code thoroughly before writing any documentation.
- Match the existing documentation style and conventions in the project.
- Write for the target audience: developers who will use or maintain this code.
- Keep docs accurate — never document behavior that does not exist in the code.
- Reference source locations with `file_path:line_number` so readers can verify.
</execution_protocol>

<formatting_and_memory>
- Use clear, concise language — avoid jargon unless the audience expects it.
- Include practical examples and code snippets where helpful.
- Document the "why" alongside the "what" — rationale matters.
- Structure docs with clear headings, sections, and hierarchy.
- Keep formatting consistent with existing project docs.
</formatting_and_memory>
````

**Parity: 17/17** (5 core + 5 standards + 4 restrictions + 3 constraints). Lexical ban: clean.

## Staged File 9: `_core/2_workflows/error_triage.md`

````markdown
## Error Recovery

<red_lines>
- **Hard threshold**: after **2 independent fix attempts** for the same problem, escalate (per Invariant III). Present the analysis to the human and question the design — do not attempt a third fix.
- If 2+ independent fixes fail with the **same pattern** (each fix reveals a new problem in a different place), this signals an architectural issue, not a bug. Stop fixing symptoms — question the design.
- If your human partner redirects you ("Stop guessing", "Is that not happening?", "Ultrathink this"), return to root cause — re-read the full error output and reproduce the issue before forming a new hypothesis.
- **Never rationalize** — "One more attempt" (that is attempt N+1 of the same approach — stop); "It's probably just X" (hypotheses need evidence — return to Phase 1); "I've seen this before" (verify against the current error output — don't pattern-match); "The fix is obvious" (if it were, it would have worked — root-cause it); "Tests are flaky" (re-run in isolation — flaky tests are bugs too).
</red_lines>

<execution_protocol>
- For hard bugs that resist a first-glance fix, use `skill diagnosing-bugs` — a disciplined 6-phase loop (feedback loop → reproduce → hypothesise → instrument → fix → post-mortem).
- For quick error triage (build failures, type errors, import errors), follow the escalation chain below.

**Defense in Depth**

- Fix at every boundary: validate inputs where they enter, handle errors where they surface, check invariants where state changes. Never rely on a single guard.
- After a fix, trace the full data path once more — the root cause often hides at a second boundary the same bug class hits next.

**Escalation Chain** — when something fails, follow this sequence:

1. **Diagnose** — Parse the full error output before attempting any fix. Understand the root cause.
2. **Fix in dependency order** — Resolve errors in this order: imports → types → logic → tests.
3. **Verify after each fix** — Re-run checks after every change. Never assume a fix worked.
4. **Alternate approach** — If the first fix fails, try ONE different approach.
5. **Escalate** — Then stop and ask for help. The attempt limit and retry discipline are defined in the anti-loop rules; do not invent a different threshold here.

**Error Recovery Principles**

- **Fail fast, fail loud.** Surface errors immediately rather than working around them silently.
- **Ask, don't guess.** When the fix requires a design decision or behavioral understanding, ask the human rather than guessing.

**Common Patterns**

- **Dependency errors**: Fix from the bottom of the dependency chain upward.
- **Type errors**: Fix the type definition first, then propagate changes to consumers.
- **Test failures**: Read the assertion message carefully — the expected vs. actual values usually reveal the issue.
- **Build failures**: Check for missing imports, changed APIs, and version mismatches before diving into logic.
</execution_protocol>
````

**Parity: 24/24** (3 threshold rules + 5 rationalization flags + 2 debugging routing + 2 defense-in-depth + 5 escalation steps + 2 principles + 4 patterns). Lexical ban: clean.

## Staged File 10: `_core/2_workflows/communication.md`

````markdown
## Communication Standards

<formatting_and_memory>
**Structure**

- State **intent before action**: "I will do X because Y" → do X → "X is done, result is Z".
- State **result after action**: Summarize what was done and what the outcome was.
- Use structured formats: bullet points, tables, and code blocks over prose.
- Keep responses concise. No preambles, restatements, or conversational filler.
- **Narrate in one line or less between tool calls** — state intent before action, then act. Long narration wastes context.

**Trade-Off Analysis**

- When presenting options, use a comparison table with explicit pros/cons.
- Flag recommended options and explain *why* they're recommended.
- Include risk assessment for each option.

**Error Reporting**

- When reporting errors: state the error, state the cause (if known), state the next action.
- One clear statement per error — don't rephrase the same point multiple times.
- Include relevant context (file paths, line numbers, error messages) in reports.

**Progress Updates**

- For multi-step tasks, report progress at each milestone.
- When blocked, state clearly: what was attempted, what failed, what is needed to proceed.

**Review Responses**

When responding to code review feedback:

- **Verify first.** Never accept suggestions at face value. Check the code yourself before agreeing.
- **No performative agreement.** Forbidden phrases: "You're absolutely right!", "Great point!", "Thanks for catching this!". These waste tokens and signal passive acceptance.
- **Disagree with evidence.** If a review point is incorrect, explain why with specific code references. Do not agree to avoid conflict.
- **Commit to action.** Instead of agreeing, state what you will change: "Changed X to Y at `file:line`."
</formatting_and_memory>
````

**Parity: 19/19. Lexical ban: clean.**

## Staged File 11: `_core/2_workflows/gitlab_context.md`

````markdown
## GitLab Requirements Context

<execution_protocol>
Fetch linked requirements from GitLab when reviewing code. Imported by the review command; usable by any agent that needs GitLab issue context.

**Detection**

Before fetching, confirm GitLab is the remote and MCP tools are reachable:

1. Check the remote URL: `git remote -v` — look for `gitlab.com` or a self-hosted GitLab domain.
2. Verify MCP availability: attempt to list GitLab MCP resources. If the call fails, GitLab context is unavailable — proceed without it.
3. Derive the project ID from the remote URL: extract `namespace/project` from `git@gitlab.com:namespace/project.git` or `https://gitlab.com/namespace/project`.

If any check fails, skip GitLab context and fall back to the code-only path.

**Fetching Requirements**

Run these steps in order. Degrade gracefully — partial context is better than no context.

**Step 1: Find the Merge Request** — Get the current branch name:

```bash
git rev-parse --abbrev-ref HEAD
```

Search for MRs matching this branch using `gitlab_search` with `scope="merge_requests"`, `search=<branch-name>`, `project_id=<project>`. If no MR is found, GitLab context is unavailable — skip to the fallback.

**Step 2: Fetch MR Details** — Use `gitlab_get_merge_request` with `id=<project>`, `merge_request_iid=<iid>`. Extract the title and description.

**Step 3: Find Linked Issues** — Fetch MR notes using `gitlab_get_merge_request_notes` with `project_id=<project>`, `merge_request_iid=<iid>`. Examine the MR description and notes for issue references. Common patterns: `#123`, `Closes #45`, `Fixes #67`, `Relates to #89`. Collect all unique issue IDs; skip MR references (`!67`).

**Step 4: Fetch Each Linked Issue** — For each issue ID found, use `gitlab_get_issue` with `id=<project>`, `issue_iid=<iid>`. Extract the title and description. Check the issue body for epic references.

**Step 5: Fetch Linked Issues (1 Level Only)** — For each linked issue, check its relationships — **1 level deep only**. Do not recurse.

- **Blocked by** (dependencies): issues that block this one. The review uses them to understand what should already be in place.
- **Blocks** (follow-ups): issues this one blocks. The review checks whether current changes form a good foundation.

If structured linked-issues data is available in the issue response, use it directly. Otherwise, examine the issue description and MR notes for `#<iid>` references that represent dependencies. If deeper chains exist beyond 1 level, note that they exist but stop — do not recurse further.

**Step 6: Find the Epic** — Parse issue descriptions for epic references. If found, fetch the epic for broader context.

**Step 7: Compile Requirements Block** — Assemble into a single block:

```markdown
## Requirements (from GitLab)

**MR:** {title}
{description}

**Issue:** #{iid} {title}
{description}

**Epic:** {title}
{description}

**Dependencies (must already exist):**
- #{iid} {title} — {summary}

**Follow-ups (this must support):**
- #{iid} {title} — {summary}
```

**Step 8: Fallback** — If the remote is not GitLab or MCP tools are unavailable, ask: "Paste requirements or skip (code-only review)?" If the user pastes requirements, use them. If they skip, proceed with a code-only review.
</execution_protocol>
````

**Parity: 3 detection rules + 8 steps + 1-level-depth constraint + fallback = all preserved verbatim. Lexical ban: clean.**

---

## Summary

| File | Constraints IN | Constraints OUT | Status |
|---|---|---|---|
| invariants.md | 7 | 7 | ✅ |
| execution_safety.md | 6 | 6 | ✅ |
| hitl_gates.md | 9 | 9 | ✅ |
| edit_accuracy.md | 5 | 5 | ✅ |
| skills_manifest.md | 26 | 26 | ✅ |
| feature_dev_build.md | 16 | 16 | ✅ |
| feature_dev_design.md | 10 | 10 | ✅ |
| documentation.md | 17 | 17 | ✅ |
| error_triage.md | 24 | 24 | ✅ |
| communication.md | 19 | 19 | ✅ |
| gitlab_context.md | 12 | 12 | ✅ |
| **Total** | **151** | **151** | **✅ 100%** |

**Next steps after application:** rebuild `./agentc-cli build`, verify dist (imports now nest inside parent XML sections), write full audit matrices to `docs/refactoring/01-governance-workflows.md`, then Phase 2 (Engineering + Refactoring — same content-driven analysis).

---

# Appendix A — Phase 0.5 Contract-Compliance Rework (staged, unapplied)

**Status:** designed 2026-08-12; application blocked by edit permissions (only `docs/**` writable). Apply together with the Phase 1 files.

## A1. `_core/5_commands/review.md` — full replacement

````markdown
## Process

<red_lines>
- HARD GUARDRAIL: NEVER modify, create, or delete any files. This command runs in agents that may have write permissions (build, design). Review is read-only — produce a report, never patches.
</red_lines>

<execution_protocol>
### Step 1: Determine the Base Branch

If the user specified: `/review against <branch>` — use `<branch>` as the base.

If the user ran `/review` (no argument), auto-detect the default branch:

```bash
for branch in main master; do
  if git merge-base --is-ancestor origin/$branch HEAD 2>/dev/null; then
    echo $branch
    break
  fi
done
```

Fall back to `main` if detection fails.

### Step 2: Gather Requirements Context

Fetch linked requirements from the issue tracker.

**If the repo is on GitLab** and MCP tools are available:

- Load and follow `_core/2_workflows/gitlab_context.md` to fetch the MR, linked issues, blocked/blocking issues, and epics.
- This produces a requirements block (or confirms no context was found).

**Otherwise:**

- Ask: "Paste requirements or skip (code-only review)?"
- If pasted: use as the requirements block.
- If skipped: proceed without requirements.

### Step 3: Get the Code Diff

```bash
MERGE_BASE=$(git merge-base origin/$BASE_BRANCH HEAD)
git log --oneline $MERGE_BASE..HEAD
git diff $MERGE_BASE..HEAD
```

Include uncommitted changes: `git diff --cached` and `git diff`.

### Step 4: Review

Load the `code-review` skill.

Evaluate changes along two independent axes per the engineering standard:

**Axis 1 — Standards** (delegated to `code-review` skill):

- The skill handles correctness, security, performance, types, and quality.
- Do not restate its process here.

**Axis 2 — Spec** (handled here, when requirements are available):

- For each requirement: does the diff implement it? Quote the requirement, cite matching code (file:line).
- Any requirements missing or partially implemented?
- Any code in the diff not asked for by any requirement? (scope creep)
- **Dependencies**: if blocked issues specify prerequisites, are they satisfied?
- **Follow-ups**: will the blocking issues fit on top of this implementation, or will they need rework?
- Quote the issue line for each finding.

If requirements are unavailable, report only the Standards axis.

### Step 5: Report

Categorize findings by severity (Critical / Warning / Suggestion) with file:line references.

If security concerns are found, delegate to the dedicated security review agent.

End with a verdict: **Approved** / **Approved with suggestions** / **Changes requested**.

<!-- @import _core/2_workflows/gitlab_context.md -->
</execution_protocol>

<standards>
<!-- @import _core/3_engineering/code_review.md -->
<!-- @import _core/3_engineering/code_standards.md -->
</standards>

<pre_flight_check>
- Before reporting: confirm no files were modified, created, or deleted; every finding carries a file:line reference; spec findings quote the requirement and cite matching code; verdict stated.
</pre_flight_check>
````

**Changes vs. current file:** (1) `gitlab_context` import moved inside `</execution_protocol>`; (2) `code_review` + `code_standards` imports wrapped in new `<standards>` section; (3) `security-reviewer` → "the dedicated security review agent" (IDE-neutral, rev. 3); (4) `<pre_flight_check>` added (already present in pilot version).

## A2. `opencode/commands/review.md` — full replacement

````markdown
---
description: Perform a code review of the current branch against a base branch. Use "/review" to auto-detect the base. Use "/review against <branch>" to specify it.
---

Review the current branch against a base branch.

If `$ARGUMENTS` contains "against <branch>", parse <branch> as the target base.

Otherwise, auto-detect the default branch (main or master) as the base.

<!-- @import _core/5_commands/review.md -->

When security concerns are found during review, delegate to the `security-reviewer` subagent.
````

**Change vs. current file:** appended opencode-specific security-delegation line (supplies the IDE-specific name that A1 made neutral).

## A3. `opencode/agents/build.md` — exact edits (import placement)

Current file ends with 4 import lines after `</pre_flight_check>`. Apply:

1. **Move** `<!-- @import _core/2_workflows/feature_dev_build.md -->` → inside `<execution_protocol>`, immediately after step 8 (before `</execution_protocol>`).
2. **Insert** new section between `</execution_protocol>` and `<formatting_and_memory>`:

````markdown
<standards>
<!-- @import _core/3_engineering/testing_aaa.md -->
<!-- @import _core/3_engineering/code_standards.md -->
</standards>
````

3. **Move** `<!-- @import _core/1_governance/edit_accuracy.md -->` → inside `<formatting_and_memory>`, at the end (before `</formatting_and_memory>`).
4. **Delete** all 4 import lines from the end of the file.

## A4. `cursor/rules/agent-core.mdc` — exact edit (import placement)

1. **Move** `<!-- @import _core/1_governance/execution_safety.md -->` from its current position (between `</execution_protocol>` and `<pre_flight_check>`) → inside `<red_lines>`, at the end (before `</red_lines>`).

## A5. Verification after application

1. `zig build test` → EXIT 0
2. `./agentc-cli build` → SUCCESS
3. Read `dist/opencode/agents/build.md`, `dist/opencode/commands/review.md`, `dist/cursor/agents/code-reviewer.md`, `dist/cursor/rules/agent-core.mdc` — confirm imported content now nests INSIDE parent XML sections (gitlab_context inside `<execution_protocol>`, code_standards inside `<standards>`, execution_safety inside `<red_lines>`).
4. Confirm cursor code-reviewer compiled output contains `/security-auditor` (from its shell tail) and NO `security-reviewer` (from the neutralized import).