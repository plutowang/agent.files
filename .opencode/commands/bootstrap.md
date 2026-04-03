---
name: bootstrap
description: "Automatically generate Host Shell templates for a new AI IDE (e.g., /bootstrap vscode). The target directory MUST already contain a README.md and .examples/ folder."
---
# IDE Expansion Initialization

You have been invoked to bootstrap the agent configurations for a new AI IDE target: **$ARGUMENTS**

## CRITICAL PREREQUISITE
You **MUST** immediately load and read the `ide-bootstrapper` skill before proceeding. 
Do not attempt to generate any files or structures until you have fully internalized the rules, Lexical Ban, and Pre-Flight Checks defined in that skill.

## EXECUTION DIRECTIVE
1. The target directory for this expansion is `./$ARGUMENTS/`.
2. Execute **Phase 2 (Pre-Flight Check)** from the `ide-bootstrapper` skill immediately.
   - Look for `./$ARGUMENTS/README.md`
   - Look for `./$ARGUMENTS/.examples/`
3. If the blueprints are missing, **STOP** and tell me what is missing.
4. If the blueprints exist, proceed through the remaining phases of the `ide-bootstrapper` skill to generate the proposed Host Shells and Macro Injections.

> **Remember:** Do not write any files to disk. Output your Expansion Plan and wait for "Approved" command.
