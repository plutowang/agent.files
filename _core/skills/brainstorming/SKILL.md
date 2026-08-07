---
name: brainstorming
description: Load before any creative work — features, components, behavior changes. Explores intent, proposes approaches, writes spec. HARD-GATE - no code before spec approval.
---

# Brainstorming: Ideas Into Designs

Turn ideas into fully formed specs through collaborative dialogue.

Announce at the start: "I'm using the brainstorming skill to turn this into a spec."

## HARD-GATE

Do NOT implement anything — no code, no scaffolding — until the spec is written and the human explicitly approves it. This applies to every project, regardless of perceived simplicity.

## Process

1. **Gather context** — Build an accurate picture of the current state: the affected code, the docs, recent commits. Delegate retrieval if you cannot read directly.
2. **Ask clarifying questions** — One at a time. Prefer multiple-choice. Understand purpose, constraints, success criteria
3. **Propose 2–3 approaches** — With trade-offs and a recommendation
4. **Present design** — Cover architecture, components, data flow, error handling, testing. Validate each section as you go
5. **Write design doc** — Save to `docs/specs/YYYY-MM-DD-<slug>.md`. Run a self-review for placeholders, contradictions, scope issues
6. **HITL Gate** — Ask the human to review the spec before proceeding

## Key Principles

- **One question at a time.** Break multi-faceted topics into separate questions
- **YAGNI ruthlessly.** Remove unnecessary features from every design
- **Propose alternatives.** Never settle on the first approach without considering others
- **Design for isolation.** Each unit should have a clear purpose, well-defined interface, and be independently testable

## After Approval

Load `writing-plans` to create the implementation plan.
