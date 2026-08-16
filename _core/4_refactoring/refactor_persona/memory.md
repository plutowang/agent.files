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
