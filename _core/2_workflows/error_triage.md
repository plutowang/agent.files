## Error Recovery

### Systematic Debugging (4-Phase)

Before any fix, complete all four phases:

#### Phase 1: Root Cause Investigation

- Read error messages and stack traces completely — they often contain the exact solution
- Reproduce the issue consistently. Document exact steps
- Check recent changes (commits, dependencies, configuration, environment)
- In multi-component systems: add diagnostic instrumentation at each boundary to identify which layer fails
- Trace data flow backward from the symptom to find the originating source

#### Phase 2: Pattern Analysis

- Find working examples of similar code in the same codebase
- Compare working vs. broken: list every difference, however small
- Understand dependencies: what config, environment, or assumptions does this component need?

#### Phase 3: Hypothesis and Testing

- Form a single, specific hypothesis: "I think X is the root cause because Y"
- Make the smallest possible change to test the hypothesis. One variable at a time
- If the hypothesis is wrong, form a new one — don't pile on fixes

#### Phase 4: Implementation

- Write a failing test case that reproduces the bug (follow TDD Iron Law)
- Implement a single fix addressing the root cause
- Verify the fix resolves the issue and no other tests break

### When Fixes Keep Failing

- If 2+ independent fixes fail with the **same pattern** (each fix reveals a new problem in a different place), this signals an architectural issue, not a bug. Stop fixing symptoms — question the design.
- If your human partner redirects you ("Stop guessing", "Is that not happening?", "Ultrathink this"), return to Phase 1.

### Escalation Chain

When something fails, follow this sequence:

1. **Diagnose** — Parse the full error output before attempting any fix. Understand the root cause.
2. **Fix in dependency order** — Resolve errors in this order: imports → types → logic → tests.
3. **Verify after each fix** — Re-run checks after every change. Never assume a fix worked.
4. **Alternate approach** — If the first fix fails, try ONE different approach.
5. **Escalate** — Then stop and ask for help. The attempt limit and retry discipline are defined in the anti-loop rules; do not invent a different threshold here.

### Error Recovery Principles

- **Fail fast, fail loud.** Surface errors immediately rather than working around them silently.
- **Ask, don't guess.** When the fix requires a design decision or behavioral understanding, ask the human rather than guessing.

### Common Patterns

- **Dependency errors**: Fix from the bottom of the dependency chain upward.
- **Type errors**: Fix the type definition first, then propagate changes to consumers.
- **Test failures**: Read the assertion message carefully — the expected vs. actual values usually reveal the issue.
- **Build failures**: Check for missing imports, changed APIs, and version mismatches before diving into logic.
