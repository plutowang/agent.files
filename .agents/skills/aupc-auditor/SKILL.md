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

You are the Principal AI Architect conducting a rigorous, holistic review of all files in the `_core/`, `opencode/`, `cursor/`, and any new IDE directories (e.g., `copilot/`). 
Your primary goal is to **optimize the Context Window** for the compiled agents by identifying redundancies, resolving logical contradictions, preventing IDE dialect leakage, and enforcing strict domain boundaries.

---

## AUDIT MATRIX (What you are looking for)

Please meticulously scan the codebase against these 5 dimensions:

### 1. The Universal Purity Check (The Lexical Ban)
- **Sanitize `_core/`**: Double-check ALL files inside the `_core/` directory. Did any IDE-specific execution mechanics (`glob`, `grep`, `Task` tool, `YAML frontmatter`, `@Codebase`, `.mdc`, or slash commands like `/explore`) accidentally leak into the universal core files?
- **Goal-Oriented Phrasing**: Are instructions in `_core/` dictating *how* to use a tool (e.g., "Use the bash tool to run X") instead of *what* the goal is (e.g., "Run X")?
- **Built-in Subagent Awareness**: Are core macros explicitly micromanaging IDE built-in tools (like Explore, Bash, Browser) instead of relying on the IDE's native auto-delegation?

### 2. The Cursor Dual-Engine Audit
- **MDC Frontmatter Hygiene (`cursor/rules/*.mdc`)**: Does any rule use `globs: ""` with `alwaysApply: false` without an incredibly precise, keyword-rich description? (This causes RAG spam).
- **Interlock Syntax (`cursor/rules/*.mdc`)**: Are subagents invoked using the correct SLASH syntax (e.g., `/security-auditor`) instead of the invalid `@` syntax?
- **Subagent Context Isolation (`cursor/agents/*.md`)**: Does the subagent prompt explicitly acknowledge that it starts with a *clean context* and must gather its own information?
- **Overthinking Triggers**: Are there toxic, process-blocking phrases in Cursor shells (e.g., "Wait for my explicit approval", "Write a detailed Markdown plan", "Consider 3 options") that will cause the model to burn Reasoning Tokens unnecessarily?

### 3. The OpenCode Permission Audit (Deadlock Guard)
- **Permission vs. Prompt Conflicts**: Does an OpenCode agent have a tool denied in its YAML (e.g., `permission.task: "explore": deny`), but its markdown prompt explicitly tells it to "delegate to explore"?
- **Edit Accuracy Isolation**: Is the OpenCode-specific workaround macro (`_core/1_governance/edit_accuracy.md`) accidentally imported into read-only agents (like `explore.md` or `verifier.md`) or global files (`AGENTS.md`)? It MUST ONLY be in write-enabled agents.

### 4. The DRY Audit (Eliminating Redundancy)
- **Shadow Redundancy**: Does an IDE Host Shell manually state a rule in its markdown body that is *already* covered by one of the `<!-- @import _core/... -->` macros it includes at the bottom?
- **Double Injection**: Is the same `_core/` macro being imported in both a global file (e.g., `AGENTS.md`) AND a file-scoped rule (e.g., `.mdc`), causing token waste when both activate?

### 5. Context Optimization (Dieting the Agents)
- **Irrelevant Imports**: Is a host shell importing a macro it does not need? 
  *Example*: A pure search agent (`explore.md`) does NOT need `<!-- @import _core/3_engineering/testing_aaa.md -->` bloating its context window.

---

## EXECUTION PROTOCOL (STRICT HITL)

You are conducting an audit. **DO NOT modify or rewrite any files yet.**

1. **Analyze**: Deeply read the requested files, trace how the macros assemble (resolving the `<!-- @import -->` chains), and evaluate them against the Audit Matrix above.
2. **Report**: Output an "Architectural Audit Report" grouped by the 5 dimensions. 
3. **Action Items**: For every issue found, provide a concrete, actionable recommendation. You must use the following strict format:
   - **[ISSUE]** (e.g., Conflict / Redundancy / Purity Breach): `[File Path A]` contains `[Toxic Phrase/Misalignment]`.
   - **[FIX]**: Remove/Edit line [X] from file [Y]. Add macro [Z].
4. **WAIT**: Stop and wait for my explicit "Approved" command before executing any of the cleanup actions.