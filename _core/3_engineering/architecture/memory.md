**Decision Templates**

**ADR** — record each decision as:

```markdown
# ADR-XXX: [Title]
## Status: [Proposed | Accepted | Deprecated | Superseded]
## Context: problem + forces
## Decision: what are we doing
## Consequences: Positive / Negative / Neutral
```

**Trade-Off Matrix** — compare options: table of weighted criteria (e.g., Complexity 3, Performance 2, Maintainability 3, Team Familiarity 2) × options scored /5, with a weighted-score row. **Decision**: [Winner] — justified by [specific trade-offs accepted].

**C4 Model** — visualize at 3 levels: Context (system + users/external systems), Container (API/Worker/DB boxes), Component (services inside one container). One diagram per level, arrows for dependencies (c4model.com).
