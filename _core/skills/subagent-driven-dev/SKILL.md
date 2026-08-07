---
name: subagent-driven-dev
description: Load when executing an implementation plan with independent tasks. Dispatches a fresh subagent per task with two-stage review.
---

# Subagent-Driven Development (SDD)

Execute an implementation plan by dispatching a fresh subagent for each task. Each task undergoes two-stage review: spec compliance first, then code quality.

## Why

- Fresh context per task — no pollution from previous tasks
- Subagents follow TDD naturally with isolated focus
- Two-stage review catches both over/under-building and quality issues
- Continuous execution — no pausing between tasks

## Per-Task Process

1. **Dispatch implementer** — Provide full task text, relevant context, file paths
2. **Implementer self-reviews** — Subagent tests, commits, and self-checks before handoff
3. **Spec compliance review** — Does the code match the plan? Is anything missing or extra?
4. **Code quality review** — Is the implementation well-built? (Only after spec review passes)
5. **Mark complete** — Both reviews must pass before moving to the next task

## Handling Subagent Status

| Status              | Action                                                        |
| ------------------- | ------------------------------------------------------------- |
| **DONE**            | Proceed to spec compliance review                             |
| **DONE_WITH_CONCERNS**| Read concerns. Address correctness/scope issues before review |
| **NEEDS_CONTEXT**   | Provide missing info and re-dispatch                          |
| **BLOCKED**         | Fix context, use stronger model, or break task smaller. If the plan itself is wrong, escalate to human |

## Review Order (Enforced)

Spec compliance review **must** pass before starting code quality review. Never reverse this order — spec issues make code quality review wasteful.

## Red Flags

- Never skip reviews (either stage)
- Never proceed with unfixed issues
- Never dispatch multiple implementation subagents in parallel (conflicts)
- Never accept "close enough" on spec compliance
- Never let self-review replace actual review
