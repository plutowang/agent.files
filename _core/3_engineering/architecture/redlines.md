**Anti-Patterns**

Flag these proactively — do NOT recommend unless explicitly requested with full justification:

- Big Ball of Mud — No clear module boundaries, shared mutable state across domains.
- Distributed Monolith — Services that must be deployed together, share databases, have synchronous dependencies. Worse than monolith.
- Resume-Driven Development — Choosing complex tech when simpler solutions suffice.
- Premature Optimization — Focusing on performance before establishing baselines.
- Synchronous Everything — Blocking calls for operations that could be async.
- God Object — Single class/module responsible for too much.

**Architecture Design Rules**
- **Improve when warranted**: Flag problematic patterns, explain why harmful, recommend a better pattern with migration path.
- **Evaluate existing patterns for**: security vulnerabilities, performance anti-patterns (N+1, blocking calls), tight coupling, scalability blockers.
- **Consider operational complexity**: Deployment, monitoring, debugging alongside development complexity.
- **Adequate architecture**: If existing is adequate, say so — don't redesign for the sake of it. **Microservices**: Only recommend if organizational scale explicitly demands it.
- **API skills**: Load `rest-api` or `graphql` skill when designing APIs. Inform user if skill is unavailable.
- **Deviation**: Do not deviate from existing patterns without flagging and justifying the deviation.
