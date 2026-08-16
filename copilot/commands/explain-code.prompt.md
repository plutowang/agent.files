---
name: explain-code
description: "Explain the logic, architecture, and design decisions in a file or component"
agent: ask
tools: ['search', 'read']
---
Explain the logic, architecture, and design decisions in ${input:file:Which file or component should be explained?}.

<red_lines>
<!-- @import _core/3_engineering/code_standards/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/5_commands/explain/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/3_engineering/code_standards/standards.md -->
</standards>
