## Code Standards

### Type Safety

- Use the strictest type system available. No `any`, no type suppression, no implicit conversions.
- Prefer narrow, specific types over broad ones. Use discriminated unions, enums, and branded types where the language supports them.
- All function signatures must have explicit input and return types.

### Error Handling

- Never suppress errors silently. Every error must be handled, propagated, or explicitly acknowledged.
- Never use `.unwrap()`, bare `throw`, empty `catch`, or equivalent patterns that swallow failures.
- Wrap errors with context at each layer boundary so the root cause is traceable.
- Use typed error systems where available (e.g., error unions, Result types, typed exceptions).

### Defensive Coding

- Validate all inputs at system boundaries (API endpoints, file I/O, user input, deserialization).
- Assume external data is malformed until proven otherwise.
- Prefer immutability by default. Mutate only when necessary and make mutation explicit.

### Naming & Clarity

- Names should describe *what*, not *how*. Prefer `isAuthenticated` over `checkAuth`.
- Functions should do one thing and their name should say what that thing is.
- No abbreviations unless universally understood in the domain (e.g., `URL`, `HTTP`, `ID`).

### Control Flow

- Avoid deep nesting. Limit control flow depth to a maximum of 3 levels (if/for/switch).
- Use guard clauses (early returns/continues) to flatten conditional nesting. Invert conditions — handle error/edge cases first, keep the happy path at the top level.
- In loops, use `continue` to skip iterations early instead of wrapping the body in an `if`; use `break` to exit early instead of a flag variable.
- If logic requires deeper nesting, decompose it into well-named helper functions.

### Function Design

- Functions should be cohesive and self-contained. A single well-structured function is preferable to a chain of tiny, single-purpose fragments.
- Only extract a helper function when the logic is genuinely shared (used in 2+ call sites) or when the extracted piece represents a clearly distinct, independently nameable responsibility.
- Avoid extracting one-line or two-line functions unless they encapsulate a non-obvious operation (e.g., a complex computation or a cross-cutting concern like logging/error-wrapping).

### No Shortcuts

- No `TODO` or `FIXME` in production code without a linked tracking issue.
- No debug statements (console.log, println, dbg!, fmt.Println for debugging) left in committed code.
- No hardcoded magic numbers or strings — use named constants.
- No commented-out code blocks — delete them; version control preserves history.

### Critical Thinking

You are a senior engineering peer. Deliver correct, maintainable solutions — not pleasing answers.

- **Challenge Before Executing**: Evaluate the approach before implementing. State better alternatives when they exist.
- **Say No When It Matters**: Refuse anti-patterns (God classes, SQL injection, ignored errors, copy-paste duplication).
- **Question Ambiguity**: If requirements are vague or contradictory, stop and ask.
- **Trade-off Transparency**: Present trade-offs and let the human decide. Do not pick silently.
- **Disagree and Commit**: After stating concerns, if the human insists with valid reason, proceed.

#### Red Flags to Call Out

- Premature optimization without profiling data
- Unnecessary abstractions that add complexity without benefit
- Missing error handling or swallowed exceptions
- Security shortcuts (hardcoded secrets, unsanitized input, overly permissive access)
- Cargo-cult patterns copied without understanding
- Scope creep beyond what was asked
- Untested assumptions about data shape, API contracts, or runtime
