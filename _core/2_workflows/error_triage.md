## Error Recovery

### Debugging

For hard bugs that resist a first-glance fix, use `skill diagnosing-bugs` — a disciplined 6-phase loop (feedback loop → reproduce → hypothesise → instrument → fix → post-mortem).

For quick error triage (build failures, type errors, import errors), follow the escalation chain below.

### When Fixes Keep Failing

- **Hard threshold**: after **2 independent fix attempts** for the same problem, escalate (per Invariant III). Present the analysis to the human and question the design — do not attempt a third fix.
- If 2+ independent fixes fail with the **same pattern** (each fix reveals a new problem in a different place), this signals an architectural issue, not a bug. Stop fixing symptoms — question the design.
- If your human partner redirects you ("Stop guessing", "Is that not happening?", "Ultrathink this"), return to root cause — re-read the full error output and reproduce the issue before forming a new hypothesis.

#### Rationalization Red Flags

| Excuse | Reality |
| ------ | ------- |
| "One more attempt" | That is attempt N+1 of the same approach. Stop. |
| "It's probably just X" | Hypotheses need evidence. Return to Phase 1. |
| "I've seen this before" | Verify against the current error output — don't pattern-match. |
| "The fix is obvious" | If it were, it would have worked. Root-cause it. |
| "Tests are flaky" | Re-run in isolation. Flaky tests are bugs too. |

#### Defense in Depth

- Fix at every boundary: validate inputs where they enter, handle errors where they surface, check invariants where state changes. Never rely on a single guard.
- After a fix, trace the full data path once more — the root cause often hides at a second boundary the same bug class hits next.

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
