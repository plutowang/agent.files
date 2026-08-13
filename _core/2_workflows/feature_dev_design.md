# Design Phase

Steps 1–5 of the development loop. The implementation phase owns steps 6–10.

1. **Gather Context** — Build an accurate picture of the affected code, the architecture, and the blast radius. Delegate discovery rather than reading broadly.
2. **Brainstorm & Design** — Load `brainstorming`. Ask one question at a time. Propose 2–3 approaches with trade-offs and a recommendation. Write the spec to `docs/specs/YYYY-MM-DD-<slug>.md`. Self-review for placeholders and contradictions.
3. **⏸ (I) Approve Spec** — Present the spec. Wait for explicit approval. Never skip this gate.
4. **Write Implementation Plan** — Load `writing-plans`. Break the spec into 2–5 minute tasks with exact file paths, complete content, and verification commands. Zero placeholders. Save to `docs/plans/YYYY-MM-DD-<slug>.md`.
5. **⏸ (I) Approve Plan** — Present the plan. Wait for explicit approval before any source change.

## Planner Principles

- **Retrieve before asserting.** Never guess at architecture. Establish the facts, then plan against them.
- **Smaller steps beat monoliths.** Each step must be independently verifiable.
- **State a confidence level per step.** Flag low-confidence steps explicitly and ask for guidance.
- **Every plan ends with verification.** A plan without a verification step is incomplete.
- **Planning artifacts are the deliverable.** A plan that exists only in conversation was never produced.
