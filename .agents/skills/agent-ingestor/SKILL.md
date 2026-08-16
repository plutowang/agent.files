---
name: agent-ingestor
description: "MANDATORY: Invoke this skill when adding new prompts, agents, rules, commands, or entire configuration folders to the agent.files repository. It acts as an immune system, reviewing new knowledge for conflicts, splitting it according to the Directory Paradigm, and seamlessly enhancing existing configurations."
disable-model-invocation: true
---

# Agent Ingestor: Knowledge Assimilation & Enhancement Protocol

**SCOPE CONSTRAINT (CRITICAL):**
You have been invoked to ingest new AI prompt configurations into the `agent.files` repository. You MUST already understand the underlying architecture of this project. If you do not understand the Directory Paradigm, the Lexical Ban, and the `<!-- @import -->` macro system, STOP and load the `agent-architect` skill immediately.

---

## 1. The Ingestion Mission

The user will provide you with new knowledge. This could be:
- A single new prompt snippet.
- A request to create a new agent, rule, or command.
- An entire directory of third-party AI configurations to analyze.

Your goal is to safely assimilate this knowledge into our existing `_core/` (Universal Philosophies) and all existing IDE Host Shells (e.g., `opencode/`, `cursor/`, `copilot/`, or any other bootstrapped IDE directories in the root). You must maximize enhancement while strictly preventing logical conflicts and IDE dialect leakage.

---

## 2. The Assimilation Pipeline

You must execute the ingestion process through the following strict phases:

### Phase 1: Contextual Analysis & Conflict Detection (The Immune Response)
1. **Analyze the Input:** Read the provided new prompts or analyze the provided external configuration folder. What is the core intent?
2. **Scan the Existing Codebase:** Compare the new intent against our existing `_core/` dimensions (`1_governance` through `5_commands`) and existing Host Shells.
3. **Conflict Detection (CRITICAL):**
   - Does the new prompt contradict an existing universal rule? (e.g., New prompt says "always use `git commit -m`", but our `_core/1_governance/execution_safety/redlines.md` says "NEVER run git commit").
   - Does the new prompt attempt to micromanage tools (e.g., "Use the explore subagent"), violating our **Goal-Oriented Philosophy**?
   - **IF A CONFLICT IS FOUND:** You MUST STOP and ask the human. Explicitly point out the contradiction: *"The new prompt suggests [X], but our existing rule in [Y] strictly forbids this. How would you like to resolve this conflict?"*

### Phase 2: Deconstruction & The Lexical Translation (Purity Enforcement)
If no conflicts exist (or if the human resolves them), you must deconstruct the new knowledge.
1. **Strip IDE Dialects & Micromanagement:** Remove any IDE-specific mechanics (`glob`, `grep`, `Task`, `YAML`, `@Codebase`, slash commands).
   - *Translation Rule*: If the input says "Use the bash tool to run X", you MUST translate it to the goal-oriented "Run X".
   - *Translation Rule*: If the input micromanages built-in subagents (e.g., "Delegate to explore"), translate it to a natural language goal (e.g., "Thoroughly research the codebase").
2. **Categorize:** Decide where the pure concepts belong in the `_core/` 4D structure (`1_governance`, `2_workflows`, `3_engineering`, `4_refactoring`, `5_commands`).

### Phase 3: IDE-Specific Routing & Host Shell Injection
Once the pure knowledge is categorized into `_core/` (either by enhancing an existing file or creating a new one), you must deploy it to the Host Shells.

**CRITICAL: You must respect the diverse routing paradigms of each IDE.**
1. **Cursor (Dual-Engine Paradigm)**:
   - Does this new knowledge belong in a file-scoped Rule (`.cursor/rules/*.mdc`)? If so, define the exact `globs`.
   - Or does it describe a new autonomous persona? If so, create an isolated Subagent (`.cursor/agents/*.md`) with the correct YAML (`model: fast` or `inherit`).
2. **OpenCode (Multi-Agent Paradigm)**:
   - Does this belong in a specific capability Agent (`opencode/agents/*.md`)?
   - **Deadlock Check**: Ensure the new instructions perfectly align with the agent's YAML permissions. Do NOT inject write-oriented macros into read-only agents.
3. **Other IDEs (e.g., Copilot)**:
   - Map the injection to their respective directories and format requirements.

---

## 3. Execution Workflow (Strict HITL)

DO NOT write or modify any files to the file system yet. You must follow a strict "Propose -> Approve -> Execute" workflow.

1. **Output the Assimilation Report**:
   - Detail any conflicts found and ask for resolution (if applicable).
   - If clear, present a highly structured Markdown plan detailing exactly which existing files will be enhanced, and which new files will be created in `_core/` and the target IDE directories.
2. **Show the Source Code**: For each modified or new file, output the exact text you will write, proving you have adhered to the **Lexical Ban** for `_core/` files and the **IDE-Specific Routing Rules** for the Host Shells.
3. **WAIT**: Stop and explicitly ask the user for approval ("Do you approve this ingestion plan?") before executing the file modifications.
