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

Your goal is to safely assimilate this knowledge into our existing `_core/` (Universal Philosophies) and all existing IDE Host Shells (e.g., `opencode/`, `cursor/`, or any other bootstrapped IDE directories in the root), maximizing enhancement while strictly preventing logical conflicts.

---

## 2. The Assimilation Pipeline

You must execute the ingestion process through the following strict phases:

### Phase 1: Contextual Analysis & Conflict Detection (The Immune Response)
1. **Analyze the Input:** Read the provided new prompts or analyze the provided external configuration folder. What is the core intent?
2. **Scan the Existing Codebase:** Compare the new intent against our existing `_core/` dimensions (`1_governance` through `5_commands`) and existing Host Shells.
3. **Conflict Detection (CRITICAL):** 
   - Does the new prompt contradict an existing rule? (e.g., New prompt says "always use `git commit -m`", but our `_core/1_governance/execution_safety.md` says "NEVER run git commit").
   - **IF A CONFLICT IS FOUND:** You MUST STOP and ask the human. Explicitly point out the contradiction: *"The new prompt suggests [X], but our existing rule in [Y] strictly forbids this. How would you like to resolve this conflict?"*

### Phase 2: Deconstruction & The Lexical Ban
If no conflicts exist (or if the human resolves them), you must deconstruct the new knowledge.
1. **Strip IDE Dialects:** Remove any IDE-specific mechanics (`glob`, `grep`, `Task`, `YAML`, `@Codebase`) from the core logical concepts.
2. **Categorize:** Decide where the pure concepts belong in the `_core/` 4D structure (`1_governance`, `2_workflows`, `3_engineering`, `4_refactoring`, `5_commands`).
3. **Identify Host Shell Requirements:** Does this new knowledge require a brand new agent or a new domain rule in the respective IDE host directories?

### Phase 3: Enhancement vs. Creation
1. **Enhancement (Merge):** If the new concept is an improvement on an *existing* topic, DO NOT create a new file. Integrate the new prompt seamlessly into the existing file.
2. **Creation (Split):** If the concept is entirely new, create a new file in the appropriate `_core/` dimension.
3. **Host Shell Updates:** If a new `_core/` file was created, ensure you plan to add the `<!-- @import _core/... -->` macro to ALL relevant existing Host Shells across all IDE directories. Draft the Host Shells adhering to their respective `README.md` schemas.

---

## 3. Execution Workflow (Strict HITL)

DO NOT write or modify any files to the file system yet. You must follow a strict "Propose -> Approve -> Execute" workflow.

1. **Output the Assimilation Report**: 
   - Detail any conflicts found and ask for resolution (if applicable).
   - If clear, present a highly structured Markdown plan detailing exactly which existing files will be enhanced, and which new files will be created in `_core/` and the target IDE directories.
2. **Show the Source Code**: For each modified or new file, output the exact text you will write, proving you have adhered to the **Lexical Ban** for `_core/` files.
3. **WAIT**: Stop and explicitly ask the user for approval ("Do you approve this ingestion plan?") before executing the file modifications.
