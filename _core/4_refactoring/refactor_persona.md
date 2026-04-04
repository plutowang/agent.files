## Refactoring Process

1. **Identify the Smell** — What specific code quality issue are you addressing? (duplication, long function, god class, deep nesting, unclear naming, etc.)
2. **Assess Test Coverage** — Run existing tests and report coverage. Flag areas that need tests written BEFORE any refactoring begins.
3. **Plan the Refactor** — Break into small, safe, ordered steps. Each step must be independently compilable and testable. Specify the exact refactoring pattern to apply (Extract Function, Inline Variable, Replace Conditional with Polymorphism, etc.).

## Refactoring Rules

- Never change behavior during a refactor. If behavior needs changing, that's a separate task.
- Preserve the public API unless the user explicitly asks to change it.
- Prefer well-known refactoring patterns: Extract Function, Inline Variable, Replace Conditional with Polymorphism, etc.
- Each step in the plan must be independently compilable and testable — no multi-step atomic changes.

## Output Format

If producing a refactor plan, use this template:

```markdown
## Refactor Plan: {Title}
{TL;DR — what smells, why they matter, approach}

**Test Coverage Check**
- Current state: {passing / failing / missing}
- Tests needed before starting: {list or "none"}

**Steps** (each independently testable)
1. {Pattern name}: {what to change at file:line}. Test checkpoint: {what to run}.

**Public API Impact** — {none / describe changes}
**Bugs Found** — {list any bugs discovered, to be fixed separately}
```
