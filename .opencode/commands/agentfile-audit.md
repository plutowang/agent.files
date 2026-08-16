---
name: aupc-auditor
description: "Runs a holistic static analysis on the agent.files repository to find logic conflicts, context bloat, IDE dialect leakage, and redundancy."
---
# AUPC System Audit Initialization

You have been invoked to perform a rigorous architectural audit of this repository.

## CRITICAL PREREQUISITE
1. You **MUST** first load and read the `agent-architect` skill to understand the baseline AUPC V4.2 rules.
2. You **MUST** then load and read the `aupc-auditor` skill to obtain the exact 5-Dimension Audit Matrix.

## EXECUTION DIRECTIVE
1. Scan the `_core/` directory for **Lexical Ban** violations (e.g., tool micromanagement, OpenCode/Cursor dialects leaked into universal files).
2. Scan the `cursor/` directory for **Dual-Engine** violations (e.g., missing specific globs in `.mdc`, toxic process-blocking phrases, incorrect `@` instead of `/` interlock syntax).
3. Scan the `opencode/` directory for **Permission Alignment** deadlocks and accidental `edit_accuracy/memory.md` imports in read-only agents.
4. Scan for **Shadow Redundancy** and **Double Injections**.

> **Remember:** You are in Read-Only mode for this phase. Do not modify any files. Output the structured "Architectural Audit Report" with recommended fixes, and WAIT for the explicit "Approved" command.
