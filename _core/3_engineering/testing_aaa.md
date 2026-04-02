## Testing Standards

### Philosophy

- Tests document intent. Every test should answer: "what behavior does this protect?"
- Prefer **integration tests** for business logic over unit tests for implementation details.
- Unit tests for pure functions and edge cases.
- Never mock what you don't own — wrap external dependencies behind interfaces, then mock the interface.

### Test Structure

- Follow the **Arrange → Act → Assert** (AAA) pattern for all tests.
- One logical assertion per test. Test one behavior, not one function.
- Test names should describe the scenario and expected outcome: `should_return_404_when_user_not_found`.

### When to Write Tests

- New public functions/methods: always.
- Bug fixes: write a failing test that reproduces the bug BEFORE fixing it.
- Refactors: verify existing tests pass before AND after. Add tests if coverage gaps exist.
- Skip tests only for: generated code, trivial getters/setters, one-off scripts.

### Coverage & Priority

- Target **80% minimum coverage** on critical paths (authentication, payment, data mutations).
- Do not chase 100% — diminishing returns past 85%.
- Coverage is a metric, not a goal. Untested edge cases matter more than high percentages.

### Table-Driven Tests

- When testing the same logic with multiple inputs, use parameterized/table-driven tests to reduce duplication.

### Anti-Patterns to Avoid

- Tests that test the implementation rather than behavior.
- Flaky tests dependent on timing, network, or filesystem state.
- Snapshot tests for anything other than serialized output (never for UI components).
- Test files that import directly from external packages or services.
