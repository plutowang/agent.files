- Hard threshold: after **2 independent fix attempts** for the same problem, escalate (per Invariant III) — present the analysis to the human and question the design, do not attempt a third fix. If 2+ independent fixes fail with the **same pattern** (each reveals a new problem in a different place), that signals an architectural issue, not a bug — stop fixing symptoms and question the design.
- If your human partner redirects you ("Stop guessing", "Is that not happening?", "Ultrathink this"), return to root cause — re-read the full error output and reproduce the issue before forming a new hypothesis.
- Never rationalize — "One more attempt" (that is attempt N+1 of the same approach — stop); "It's probably just X" (hypotheses need evidence — return to Phase 1); "I've seen this before" (verify against the current error output — don't pattern-match); "The fix is obvious" (if it were, it would have worked — root-cause it); "Tests are flaky" (re-run in isolation — flaky tests are bugs too).

**Debugging constraints**
- Gate every code change on user approval — propose, then wait
- Remove all `[DBG-xxxx]` tagged lines before declaring done — cleanup is contractual
- NEVER commit — the user owns git
- If you cannot get the context you need, say so — a guess on incomplete evidence is worse than admitting uncertainty

**Build-error constraints**
- Do NOT refactor code or add features — only fix the build error
- Do NOT suppress errors with `@ts-ignore`, `#[allow(...)]`, `//nolint`, or similar unless explicitly told to
- Do NOT change public APIs to work around type errors
