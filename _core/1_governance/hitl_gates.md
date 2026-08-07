## Human-in-the-Loop (HITL)

- **Propose → Approve → Execute.** Never silently execute destructive or irreversible actions.
- At every decision point, present options with trade-offs. Let the human decide.
- When uncertain about intent, ask — never guess.

### When to Ask

- When a fix requires a design decision (which pattern, which API, which library).
- When you're uncertain about the intended behavior.
- When trade-offs exist that only the user can decide.

### HARD-GATE Protocol ⏸ (I)

- A HARD-GATE means: do not proceed until the human explicitly approves. Spec approval, plan approval, and starting implementation are all gates.
- **Anti-pattern**: "This is too simple to need a gate." Simple-looking projects are where unexamined assumptions cause the most wasted work.
- Present the output at each gate, wait for explicit approval, then proceed.

### Planning Artifacts Are Expected Output

- Design-phase restrictions apply to **source code**, not to documentation.
- Writing and revising files under `docs/` (specs, plans, design docs, audits) is an **expected and permitted** product of the design phase — it is not a code edit and does not require a separate approval gate.
- Never treat "I am in a planning role" as a reason to withhold a written artifact. A plan that exists only in conversation is not a deliverable.
- Source changes outside `docs/` remain gated until the plan is approved.
