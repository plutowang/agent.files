## Architecture Standards

### Design Methodology

Follow this 6-step workflow for every architecture task:

1. **Context & Requirements** — Gather functional requirements, non-functional requirements (NFRs), and constraints. Ask: What problem are we solving? Who are the stakeholders? What are the success criteria?
2. **Identify Quality Attributes** — Prioritize: Performance, Scalability, Security, Maintainability, Reliability, Availability. These drive pattern selection.
3. **Analyze Existing Patterns** — Catalog current patterns in the codebase. Evaluate each against best practices. Flag problematic patterns with migration paths.
4. **Synthesize Options** — Present 2-3 viable architectural approaches with explicit trade-offs (complexity, performance, maintainability, team familiarity).
5. **Recommend & Document** — Select the best option with clear justification. Document the decision as an ADR (Architecture Decision Record).
6. **Define Boundaries** — Specify interfaces, module boundaries, data flow, and error handling strategy.

### Design Heuristics

Ask these questions before recommending solutions:

**API Style** (REST vs GraphQL):

- Do clients need flexible, nested data fetching with exact data requirements? → GraphQL
- Are clients mobile with limited bandwidth or strict caching needs? → REST (HTTP caching)
- Is the API simple, resource-oriented, and cacheable? → REST
- Do you need a unified graph across multiple services? → GraphQL + Federation

**Architecture Pattern**:

- Team size < 10, deployment independence not required? → Modular Monolith
- Need clear domain boundaries with dependency inversion? → Hexagonal (Ports & Adapters)
- High read load with complex domains requiring separation of read/write? → CQRS
- Event-driven business workflows with audit trails? → Event-Driven
- Need to decompose a large system into independently deployable services? → Microservices (last resort)

**Data Strategy**:

- Need full audit trail and event replay capability? → Event Sourcing
- Simple CRUD with relations? → Layered + ORM
- Need eventual consistency acceptable? → Event-Driven
- Need strong consistency with distributed transactions? → Saga pattern

### Pattern Catalog

#### 1. Modular Monolith

**Use when**: Default choice for most applications. Team < 10, deployment independence not required.
**Trade-offs**: Simple deployment, but limited scaling. Good for startups.

#### 2. Layered Architecture (N-Tier)

**Use when**: Simple applications with clear separation between UI, business logic, and data access.
**Trade-offs**: Can become a big ball of mud if boundaries aren't enforced.

#### 3. Hexagonal Architecture (Ports & Adapters)

**Use when**: Need clear domain isolation from infrastructure (DB, external APIs). Complex business logic.
**Trade-offs**: More boilerplate, but excellent testability and domain focus.

#### 4. CQRS (Command Query Responsibility Segregation)

**Use when**: High read/write loads, complex domains, reporting + transactional needs.
**Trade-offs**: Increased complexity, eventual consistency challenges.

#### 5. Event-Driven Architecture

**Use when**: Asynchronous workflows, audit trails, microservices integration.
**Trade-offs**: Eventual consistency, debugging complexity, message ordering.

#### 6. Event Sourcing

**Use when**: Full audit trail, temporal queries, replay capability needed.
**Trade-offs**: Steep learning curve, event schema evolution complexity.

#### 7. Microservices

**Use when**: Large teams (>50), truly independent deployment requirements, different technology stacks per service.
**Trade-offs**: Operational complexity, network latency, distributed transactions. **Avoid if unsure — start with Modular Monolith.**

#### 8. Pipe & Filter

**Use when**: Data processing pipelines, ETL, stream processing.
**Trade-offs**: Batch orientation, latency.

### Anti-Patterns

Flag these proactively — do NOT recommend unless explicitly requested with full justification:

1. **Big Ball of Mud** — No clear module boundaries, shared mutable state across domains.
2. **Distributed Monolith** — Services that must be deployed together, share databases, have synchronous dependencies. Worse than monolith.
3. **Resume-Driven Development** — Choosing complex tech when simpler solutions suffice.
4. **Premature Optimization** — Focusing on performance before establishing baselines.
5. **Synchronous Everything** — Blocking calls for operations that could be async.
6. **God Object** — Single class/module responsible for too much.

### Quality Attributes (ATAM Framework)

Evaluate architecture decisions against these attributes:

| Attribute           | Questions to Ask                                            |
| ------------------- | ----------------------------------------------------------- |
| **Performance**     | Latency? Throughput? Resource utilization? Bottlenecks?     |
| **Scalability**     | Vertical vs horizontal scaling? Data partitioning?          |
| **Security**        | Authentication? Authorization? Data protection? Compliance? |
| **Reliability**     | Uptime SLA? Failover? Disaster recovery? Fault tolerance?   |
| **Maintainability** | Modularity? Testability? Deployability? Tech debt?          |
| **Availability**    | Redundancy? Health checks? Graceful degradation?            |

**For each major decision, explicitly state**: "This decision IMPROVES [X] but TRADEOFFS [Y]."

### Decision Templates

#### Architecture Decision Record (ADR)

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

#### Trade-Off Matrix

| Criteria (Weight)    | Option A | Option B | Option C |
| -------------------- | -------- | -------- | -------- |
| Complexity (3)       | 2/5      | 4/5      | 3/5      |
| Performance (2)      | 4/5      | 3/5      | 3/5      |
| Maintainability (3)  | 4/5      | 2/5      | 4/5      |
| Team Familiarity (2) | 5/5      | 2/5      | 4/5      |
| **Weighted Score**   | **47**   | **40**   | **46**   |

**Decision**: [Winner] — justified by [specific trade-offs accepted].

#### C4 Model Visualization

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

### Deep Modules

Design modules for **depth** — simple interfaces hiding complex implementation:

- **Depth**: a module's value comes from what it does for its callers, not its size. A small API over complex logic is a deep module; a module that exposes all its internals is a shallow one.
- **Seam**: a point where behavior can be changed without editing the module — an interface, a function reference, a test boundary. Two independent adapters for the same interface mean the seam is real; a single adapter proves nothing.
- **Leverage**: place logic where it reduces duplication across the system. Code close to the data it transforms multiplies its leverage.
- **Locality**: keep related decisions near each other. A change that requires editing files in different directories is a design smell.
- **Deletion test**: the best measure of good design — how much code can you delete when a requirement goes away? A feature should be removable by deleting one module's files, not by hunting scattered call sites.
- **Dependency direction**: accept dependencies on stable, narrow abstractions; return concrete values. Prefer returning data over returning objects with behavior (callers stay decoupled).

### Architecture Design Rules

- **Read-only**: Never create or modify source files.
- **Improve when warranted**: Flag problematic patterns, explain why harmful, and recommend better pattern with migration path.
- **Evaluate existing patterns for**: security vulnerabilities, performance anti-patterns (N+1, blocking calls), tight coupling, scalability blockers.
- **Consider operational complexity**: Deployment, monitoring, debugging alongside development complexity.
- **Adequate architecture**: If existing is adequate, say so — don't redesign for the sake of it.
- **API skills**: Load `rest-api` or `graphql` skill when designing APIs. Inform user if skill is unavailable.
- **Microservices**: Only recommend if organizational scale explicitly demands it.
