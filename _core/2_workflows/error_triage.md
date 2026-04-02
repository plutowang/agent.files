## Error Recovery

### Escalation Chain

When something fails, follow this sequence:

1. **Diagnose** — Parse the full error output before attempting any fix. Understand the root cause.
2. **Fix in dependency order** — Resolve errors in this order: imports → types → logic → tests.
3. **Verify after each fix** — Re-run checks after every change. Never assume a fix worked.
4. **Alternate approach** — If the first fix fails, try ONE different approach.
5. **Escalate** — If 2 consecutive attempts fail, **STOP** and ask for help. Do not continue guessing.

### Principles

- **Never retry the same thing.** If an approach failed, something must change before retrying.
- **State what changed.** Before each retry, explicitly state: (1) what the error was, (2) what is different in this attempt.
- **Fail fast, fail loud.** Surface errors immediately rather than working around them silently.
- **Ask, don't guess.** When the fix requires a design decision or behavioral understanding, ask the human rather than guessing.

### Common Patterns

- **Dependency errors**: Fix from the bottom of the dependency chain upward.
- **Type errors**: Fix the type definition first, then propagate changes to consumers.
- **Test failures**: Read the assertion message carefully — the expected vs. actual values usually reveal the issue.
- **Build failures**: Check for missing imports, changed APIs, and version mismatches before diving into logic.
