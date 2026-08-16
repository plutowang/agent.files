**Decision Templates**

**Architecture Decision Record (ADR)**

```markdown
# ADR-XXX: [Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Context
What is the problem? What are the forces at play?

## Decision
What are we doing?

## Consequences
- **Positive**: [benefits]
- **Negative**: [trade-offs]
- **Neutral**: [risks that need monitoring]
```

**Trade-Off Matrix**

| Criteria (Weight) | Option A | Option B | Option C |
| --- | --- | --- | --- |
| Complexity (3) | 2/5 | 4/5 | 3/5 |
| Performance (2) | 4/5 | 3/5 | 3/5 |
| Maintainability (3) | 4/5 | 2/5 | 4/5 |
| Team Familiarity (2) | 5/5 | 2/5 | 4/5 |
| **Weighted Score** | **47** | **40** | **46** |

**Decision**: [Winner] — justified by [specific trade-offs accepted].

**C4 Model Visualization**

```bash
Level 1: Context
┌─────────────────────────────────────┐
│         System Under Design          │
│  [Users, External Systems]           │
└─────────────────────────────────────┘

Level 2: Container
┌──────────┐  ┌──────────┐  ┌──────────┐
│   API     │  │  Worker  │  │   DB     │
└──────────┘  └──────────┘  └──────────┘

Level 3: Component
┌─────────────────────────────────────┐
│         API Service                  │
│  ┌──────────┐  ┌──────────────┐    │
│  │ Controller│  │   Service    │   │
│  └──────────┘  └──────────────┘    │
└─────────────────────────────────────┘
```
