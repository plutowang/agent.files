---
name: fix-issue
description: "Diagnose and fix a bug or issue"
agent: agent
tools: ['search', 'read', 'edit', 'execute']
---
Diagnose and fix: ${input:issue:Describe the bug or failing behavior}.

<red_lines>
<!-- @import _core/3_engineering/code_standards/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/5_commands/fix/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/3_engineering/code_standards/standards.md -->
</standards>
