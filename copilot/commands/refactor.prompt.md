---
name: refactor
description: "Analyze and refactor code for improved quality using extraction patterns"
agent: agent
tools: ['read', 'search', 'edit']
---
Analyze and refactor ${input:target:Which file or module should be refactored?} for improved quality, preserving all existing behavior.

<red_lines>
<!-- @import _core/4_refactoring/smell_detection/redlines.md -->
</red_lines>

<execution_protocol>
<!-- @import _core/5_commands/refactor/protocol.md -->
<!-- @import _core/4_refactoring/smell_detection/protocol.md -->
</execution_protocol>

<standards>
<!-- @import _core/4_refactoring/smell_detection/standards.md -->
<!-- @import _core/4_refactoring/extraction_patterns/standards.md -->
</standards>
