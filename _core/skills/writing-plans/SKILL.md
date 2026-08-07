---
name: writing-plans
description: Load after spec approval, before touching code. Creates granular implementation plan with exact file paths, code, and verification steps.
---

# Writing Plans: Granular Task Breakdown

Break the approved spec into bite-sized, sequential tasks. Assume the implementer has zero context — provide everything they need inline.

Announce at the start: "I'm using the writing-plans skill to break this spec into tasks."

## Task Granularity

Each step should take 2–5 minutes:

- Write the failing test → Run to confirm it fails → Implement minimal code → Run to confirm it passes → Commit

## Task Structure

Each task must include:

- **Exact file paths** for all files to create or modify
- **Complete code** for every step (no "similar to Task N")
- **Exact verification commands** with expected output
- **Commit message** for the task

## Zero Placeholders

These are plan failures — never use them:

- "TBD", "TODO", "implement later"
- "Add appropriate error handling" (without specifics)
- "Write tests for the above" (without actual test code)
- References to types or functions not defined in any task

## Plan Header

Start every plan with:

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence describing what this builds]
**Approach:** [2-3 sentences about architecture]
**Tech Stack:** [Key technologies]
```

## Self-Review

After writing, check:

1. **Spec coverage** — Every spec requirement maps to at least one task
2. **Placeholder scan** — No TBD, TODO, or vague instructions
3. **Type consistency** — Names and signatures match across tasks

## Execution Handoff

Save the plan to `docs/plans/YYYY-MM-DD-<slug>.md`, then choose the execution path by size:

- **1–3 tasks** — execute inline in this session, one task at a time, with a verification checkpoint after each. Do not spin up delegated execution for work this small.
- **4+ tasks, or tasks that are genuinely independent** — hand off to `subagent-driven-dev` so each task gets fresh context and two-stage review.

State which path you chose and why before starting.
