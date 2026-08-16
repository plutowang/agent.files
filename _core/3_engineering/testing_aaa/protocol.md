**RED → GREEN → REFACTOR**
- **RED — Write Failing Test**: one minimal test showing expected behavior (clear name, real code, minimal mocks); verify it fails for the expected reason (feature missing, not a typo).
- **GREEN — Minimal Code to Pass**: only enough code to pass — no extra features, no unrelated refactors.
- **REFACTOR — Clean Up**: remove duplication, improve names — keep tests green, never add behavior.
**Order Matters**
Tests written after code prove nothing — they pass immediately and may test the wrong thing. Test-first forces discovery of edge cases before implementation, prevents regressions, and documents behavior.
**When Stuck**
- Don't know how to test → write the wished-for API and the assertion first; ask the human if still stuck.
- Test too complicated → the design is too complicated. Simplify the interface.
- Must mock everything → the code is too coupled. Use dependency injection.
- Test setup is huge → extract helpers; still complex? Simplify the design.
**When to Write Tests**
- New public functions/methods: always (test-first).
- Bug fixes: a failing test that reproduces the bug BEFORE fixing it.
- Refactors: verify existing tests pass before AND after; add tests if coverage gaps exist.
- Skip only: generated code, trivial getters/setters, one-off scripts.
