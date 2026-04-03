---
name: aupc-auditor
description: "MANDATORY: Invoke this skill to perform a holistic architectural audit, redundancy check, and context-window optimization on the agent.files repository. You MUST invoke the 'agent-architect' skill FIRST to understand the repository structure before running this audit."
disable-model-invocation: true
---

# AUPC Holistic Architectural Audit & Optimization

**PRE-REQUISITE CHECK (CRITICAL):**
Before proceeding with this audit, you MUST have already loaded and understood the `agent-architect` skill. If you do not understand the Directory Paradigm, the Lexical Ban, or the `<!-- @import -->` macro system, STOP and load the `agent-architect` skill immediately.

---

## AUDIT MISSION

You are the Principal AI Architect conducting a rigorous, holistic review of all files in the `_core/`, `opencode/`, and `cursor/` directories. 
Your primary goal is to **optimize the Context Window** for the compiled agents by identifying redundancies, resolving logical contradictions, and enforcing strict domain boundaries.

---

## AUDIT MATRIX (What you are looking for)

Please meticulously scan the codebase against these 4 dimensions:

### 1. The DRY Audit (Eliminating Redundancy)
- **Overlapping Philosophies**: Are two files in `_core/` saying the exact same thing but in different words? (e.g., Do `code_standards.md` and `architecture.md` both contain rules about the DRY principle?)
- **Shadow Redundancy**: Does an IDE Host Shell (e.g., `opencode/agents/plan.md`) manually state a rule in its markdown body that is *already* covered by one of the `<!-- @import _core/... -->` macros it includes at the bottom?

### 2. The Logic & Conflict Audit (Resolving Contradictions)
- **Permission vs. Prompt Conflicts**: Does an OpenCode agent have `permission: { edit: "deny" }` in its YAML, but its markdown prompt explicitly tells it to "modify the configuration file"?
- **Core vs. Shell Conflicts**: Does a universal rule in `_core/1_governance/execution_safety.md` state "Never run bash to edit files", but a specific slash command in `cursor/commands/` attempts to do exactly that?
- **Role Confusion**: Is a read-only subagent (like Cursor's `verifier.md` or OpenCode's `explore.md`) being told to "analyze system architecture", when that should strictly be the `plan` or `architect` agent's job?

### 3. Context Optimization (Dieting the Agents)
- **Irrelevant Imports**: Is a host shell importing a macro it does not need? 
  *Example*: The `explore` agent only searches files; it does NOT need `<!-- @import _core/3_engineering/testing_aaa.md -->` bloating its context window.
- **Over-Fragmentation**: Can any excessively fragmented files in `_core/` be logically merged to reduce the number of import statements and parsing overhead?

### 4. Purity Check (The Lexical Ban)
- **Sanitize `_core/`**: Double-check ALL files inside the `_core/` directory. Did any IDE-specific execution mechanics (`glob`, `grep`, `Task` tool, `Cursor`, `YAML frontmatter`, `@Codebase`, `.mdc`) accidentally leak into the universal core files during a previous edit?

---

## EXECUTION PROTOCOL (STRICT HITL)

You are conducting an audit. **DO NOT modify or rewrite any files yet.**

1. **Analyze**: Deeply read the requested files, trace how the macros assemble (resolving the `<!-- @import -->` chains), and evaluate them against the Audit Matrix above.
2. **Report**: Output an "Architectural Audit Report" grouped by the 4 dimensions. 
3. **Action Items**: For every issue found, provide a concrete, actionable recommendation. You must use the following strict format:
   - **[ISSUE]** (e.g., Conflict / Redundancy / Purity Breach): `[File Path A]` conflicts with `[File Path B]` regarding [Concept].
   - **[FIX]**: Remove/Edit line [X] from file [Y]. Add macro [Z].
4. **WAIT**: Stop and wait for my explicit "Approved" command before executing any of the cleanup actions.
