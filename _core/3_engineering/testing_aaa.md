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

### TDD Iron Law

**NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.** Write code before a test? Delete it. Start over.

#### RED — Write Failing Test

- Write one minimal test showing expected behavior. Clear name. Real code, minimal mocks.
- Verify the test fails for the expected reason (feature missing, not a typo).

#### GREEN — Minimal Code to Pass

- Write only enough code to make the test pass. No extra features, no unrelated refactors.

#### REFACTOR — Clean Up

- Remove duplication, improve names. Keep all tests green. Never add behavior during refactor.

#### Order Matters

Tests written after code prove nothing — they pass immediately and may test the wrong thing. Test-first forces discovery of edge cases before implementation, prevents regressions, and documents behavior.

#### Rationalizations (Do Not Use)

| Excuse                      | Reality                                                      |
| --------------------------- | ------------------------------------------------------------ |
| "Too simple to test"        | Simple code breaks. Test takes seconds.                      |
| "I'll test after"           | Tests passing immediately prove nothing.                     |
| "Already manually tested"   | Manual is ad-hoc. No record, can't re-run.                   |
| "Deleting code is wasteful" | Sunk cost fallacy. Untested code is technical debt.          |
| "Need to explore first"     | Throw away exploration, start with TDD.                      |
| "TDD will slow me down"     | Debugging without tests is slower than TDD.                  |

### When to Write Tests

- New public functions/methods: always (test-first).
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
