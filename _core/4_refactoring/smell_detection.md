## Refactoring: Smell Detection

### Principles

- **Never change behavior during a refactor.** If behavior needs changing, that's a separate task.
- **Preserve the public API** unless explicitly agreed to change it.
- **Test first.** Ensure adequate test coverage exists before refactoring. Write missing tests first.
- **Small, independently verifiable steps.** Each refactoring step should leave the codebase compilable and all tests passing.
- **Report bugs separately.** If bugs are discovered during refactoring, document them — don't fix them in the same change.

### When to Refactor

- Before adding a feature to code that has quality issues — clean first, then build.
- When duplication, deep nesting, or unclear naming blocks understanding.
- When a function exceeds ~50 lines or takes 5+ parameters — consider decomposition.

### Extraction Discipline

- **Only extract when the piece is genuinely shared** (used in 2+ places). Do not extract unique logic just to shorten a function.
- **Do not fragment functions into tiny pieces.** A 5-line function that calls three 2-line helpers is worse than a self-contained 20-line function.
- **Every extracted function must justify its existence** — a clear, independent responsibility and a name describing *what* it does, not *how*. If the block cannot be named that way, do not extract it.
