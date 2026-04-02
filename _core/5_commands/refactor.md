## Process

1. Run smell detection: duplication, deep nesting, long functions (>50 lines), excessive parameters (5+).
2. Propose specific refactorings from the extraction pattern catalog.
3. ⏸ Present the refactoring plan with trade-offs. Wait for approval before making changes.
4. Execute approved refactorings in small, independently verifiable steps.
5. Verify all existing tests still pass after each step.

<!-- @import _core/4_refactoring/extraction_patterns.md -->
<!-- @import _core/4_refactoring/smell_detection.md -->
<!-- @import _core/1_governance/hitl_gates.md -->
<!-- @import _core/1_governance/anti_loop.md -->
