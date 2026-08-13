# Implementation Phase

Steps 6–10 of the development loop. Do not begin until the plan is approved ⏸ (I).

1. **Isolate Workspace (conditional)** — Load `git-worktrees` only when starting from the default branch. If already on a working branch, build there.
2. **Execute** — Load `subagent-driven-dev`. Delegate one task at a time with fresh context. Per task: ⏸ (IV) RED → GREEN → REFACTOR, then two-stage review — spec compliance first, code quality second.
3. **Verify** — Load `verification-gate`. No completion claim without fresh evidence. Run tests, linters, and type-checkers.
4. **Report** — Present results: what was done, what was verified, what remains uncertain. Then wait.
5. **⏸ (II) Commit** — Only when explicitly instructed.

## Development Principles

- **Read before write.** Understand existing code before modifying it.
- **Locate before reading.** Find the relevant file before pulling it into context.
- **Edit over rewrite.** Prefer targeted modifications to replacing whole files.
- **Verify after every change.** Never assume a change worked.
- **Minimal scope.** Change only what the plan requires. No drive-by refactors.
- **Treat the plan as a blueprint.** If it is wrong, surface it and stop — never silently reinterpret it.

## Execution Steps

- For tasks with 3+ steps, create an explicit task list before starting.
- Each task names its file paths, functions, and expected behaviour.
- Update task status as work progresses. Finish the current task before starting the next.

## Verification Checklist

Before claiming any task complete:

- Code compiles and type-checks cleanly
- Existing tests still pass
- New behaviour has tests ⏸ (IV)
- No credentials, secrets, or keys introduced ⏸ (V)
- Error cases handled — no bare throws, no swallowed errors
- No debug statements left behind
