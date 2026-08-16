**Design Heuristics**

Ask these questions before recommending solutions:

**API Style** (REST vs GraphQL):
- Do clients need flexible, nested data fetching with exact data requirements? → GraphQL
- Are clients mobile with limited bandwidth or strict caching needs? → REST (HTTP caching)
- Is the API simple, resource-oriented, and cacheable? → REST
- Do you need a unified graph across multiple services? → GraphQL + Federation

**Pattern Catalog**

**1. Modular Monolith** — **Use when**: Default choice for most applications. Team < 10, deployment independence not required. **Trade-offs**: Simple deployment, but limited scaling. Good for startups.

**2. Layered Architecture (N-Tier)** — **Use when**: Simple applications with clear separation between UI, business logic, and data access. **Trade-offs**: Can become a big ball of mud if boundaries aren't enforced.

**3. Hexagonal Architecture (Ports & Adapters)** — **Use when**: Need clear domain isolation from infrastructure (DB, external APIs). Complex business logic. **Trade-offs**: More boilerplate, but excellent testability and domain focus.

**4. CQRS (Command Query Responsibility Segregation)** — **Use when**: High read/write loads, complex domains, reporting + transactional needs. **Trade-offs**: Increased complexity, eventual consistency challenges.

**5. Event-Driven Architecture** — **Use when**: Asynchronous workflows, audit trails, microservices integration. **Trade-offs**: Eventual consistency, debugging complexity, message ordering.

**6. Event Sourcing** — **Use when**: Full audit trail, temporal queries, replay capability needed. **Trade-offs**: Steep learning curve, event schema evolution complexity.

**7. Microservices** — **Use when**: Large teams (>50), truly independent deployment requirements, different technology stacks per service. **Trade-offs**: Operational complexity, network latency, distributed transactions. **Avoid if unsure — start with Modular Monolith.**

**8. Pipe & Filter** — **Use when**: Data processing pipelines, ETL, stream processing. **Trade-offs**: Batch orientation, latency.

**9. Saga Pattern** — **Use when**: Distributed transactions needing strong consistency across services. **Trade-offs**: Complex compensation logic, eventual consistency windows.

**Quality Attributes (ATAM Framework)**

Evaluate architecture decisions against these attributes:

| Attribute | Questions to Ask |
| --- | --- |
| **Performance** | Latency? Throughput? Resource utilization? Bottlenecks? |
| **Scalability** | Vertical vs horizontal scaling? Data partitioning? |
| **Security** | Authentication? Authorization? Data protection? Compliance? |
| **Reliability** | Uptime SLA? Failover? Disaster recovery? Fault tolerance? |
| **Maintainability** | Modularity? Testability? Deployability? Tech debt? |
| **Availability** | Redundancy? Health checks? Graceful degradation? |

**For each major decision, explicitly state**: "This decision IMPROVES [X] but TRADEOFFS [Y]."

**Deep Modules**

Design modules for **depth** — simple interfaces hiding complex implementation:

- **Depth**: a module's value comes from what it does for its callers, not its size. A small API over complex logic is a deep module; a module that exposes all its internals is a shallow one.
- **Seam**: a point where behavior can be changed without editing the module — an interface, a function reference, a test boundary. Two independent adapters for the same interface mean the seam is real; a single adapter proves nothing.
- **Leverage**: place logic where it reduces duplication across the system. Code close to the data it transforms multiplies its leverage.
- **Locality**: keep related decisions near each other. A change that requires editing files in different directories is a design smell.
- **Deletion test**: the best measure of good design — how much code can you delete when a requirement goes away? A feature should be removable by deleting one module's files, not by hunting scattered call sites.
- **Dependency direction**: accept dependencies on stable, narrow abstractions; return concrete values. Prefer returning data over returning objects with behavior (callers stay decoupled).
