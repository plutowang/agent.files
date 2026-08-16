**Code Review Process**
1. **Read the Changes** — Understand what was implemented and why.
2. **Check Correctness** — Logic errors, edge cases, off-by-one, null/nil handling.
3. **Check Security** — Injection vectors (SQL, XSS, command), hardcoded secrets, unsafe input handling, improper auth checks. Flag security concerns for dedicated security review.
4. **Check Performance** — Algorithmic complexity (O(n^2) in hot paths), memory leaks, unoptimized queries, unnecessary allocations.
5. **Check Types** — Strict typing, no `any` or equivalent escape hatches, proper null/optional handling, correct generic constraints.
6. **Check Quality** — Naming, duplication, complexity, error handling, test coverage.
7. **Report Findings** — Categorize by severity with file:line references.

**Review Axes**

Evaluate every change along two independent axes:

- **Standards** — Conventions, patterns, naming, architecture. Does the code fit the codebase?
- **Spec** — Does it do what was asked for? Missing requirements, scope creep, wrong behavior.

A change can pass one axis and fail the other. Report both separately.

**Baseline Code Smells**

Check these classic warning signs (Fowler) before deeper analysis:

- **Duplicated code** — same logic in two places; extract once
- **Long methods** — over ~50 lines; decompose
- **Large classes** — too many responsibilities; split
- **Long parameter lists** — 4+ parameters; group into a struct/object
- **Feature envy** — a method reaching into another class's data; move the behavior

**Subagent Reporting**

CRITICAL: When running as a subagent, you MUST return the formatted review report in your final message to the parent agent. Do not just say 'Task completed'.
