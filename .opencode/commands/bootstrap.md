---
name: bootstrap
description: "Automatically generate Host Shell templates for a new AI IDE (e.g., /bootstrap copilot). The target directory MUST already contain a README.md and .examples/ folder."
---
# IDE Expansion Initialization

You have been invoked to bootstrap the agent configurations for a new AI IDE target: **$ARGUMENTS**

## CRITICAL PREREQUISITE
1. You **MUST** first load and read the `agent-architect` skill to understand the AUPC V4.2 baseline (Directory Paradigm, Lexical Ban, Goal-Oriented phrasing).
2. You **MUST** then load and read the `ide-bootstrapper` skill to execute the expansion protocol.
Do not attempt to generate any files or structures until you have fully internalized both skills.

## EXECUTION DIRECTIVE
1. The target directory for this expansion is `./$ARGUMENTS/`.
2. Execute **Phase 2 (Pre-Flight Check)** from the `ide-bootstrapper` skill immediately.
   - Look for `./$ARGUMENTS/README.md`
   - Look for `./$ARGUMENTS/.examples/`
3. If the blueprints are missing, **STOP** and tell me exactly what is missing.
4. If the blueprints exist, analyze their routing paradigm (Monolithic, Multi-Agent, or Dual-Engine) and proceed through the remaining phases to generate the proposed Host Shells and `<!-- @import -->` Macro Injections.

> **Remember:** Do not write any files to disk. Output your Expansion Plan and WAIT for the explicit "Approved" command.