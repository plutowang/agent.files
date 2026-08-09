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

### TDD Iron Law ⏸ (IV)

**NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.** Write code before a test? Delete it. Start over.

**Violating the letter is violating the spirit.** "Tests after achieve the same result" is not a technical argument — it is rationalization. A test that never failed proves nothing.

#### RED — Write Failing Test

- Write one minimal test showing expected behavior. Clear name. Real code, minimal mocks.
- Verify the test fails for the expected reason (feature missing, not a typo).

#### GREEN — Minimal Code to Pass

- Write only enough code to make the test pass. No extra features, no unrelated refactors.

#### REFACTOR — Clean Up

- Remove duplication, improve names. Keep all tests green. Never add behavior during refactor.

#### Order Matters

Tests written after code prove nothing — they pass immediately and may test the wrong thing. Test-first forces discovery of edge cases before implementation, prevents regressions, and documents behavior.

#### Red Flags — Stop and Restart

Any of these means: delete the code and restart with TDD.

- Production code written before a test
- Test passes on first run (you tested existing behavior)
- Can't explain why the test failed
- "Keep this code as reference" while writing tests
- Rationalizing "just this once"
- Tests added after implementation "to catch up"

#### Rationalizations (Do Not Use)

| Excuse                      | Reality                                                      |
| --------------------------- | ------------------------------------------------------------ |
| "Too simple to test"        | Simple code breaks. Test takes seconds.                      |
| "I'll test after"           | Tests passing immediately prove nothing.                     |
| "Already manually tested"   | Manual is ad-hoc. No record, can't re-run.                   |
| "Deleting code is wasteful" | Sunk cost fallacy. Untested code is technical debt.          |
| "Need to explore first"     | Throw away exploration, start with TDD.                      |
| "TDD will slow me down"     | Debugging without tests is slower than TDD.                  |
| "Keep it as reference"      | You will adapt it — that is testing after. Delete means delete. |
| "Tests after do the same"   | Tests-after verify the code you remembered to check, not the behavior you'd have discovered. |
| "Manual test is faster"     | Manual doesn't prove edge cases and can't be re-run.         |
| "Existing code has no tests"| You are improving it — start with the new code.              |

#### When Stuck

| Problem                     | Solution                                                     |
| --------------------------- | ------------------------------------------------------------ |
| Don't know how to test      | Write the wished-for API and the assertion first. Ask the human if still stuck. |
| Test too complicated        | The design is too complicated. Simplify the interface.       |
| Must mock everything        | The code is too coupled. Use dependency injection.           |
| Test setup is huge          | Extract helpers. Still complex? Simplify the design.         |

### When to Write Tests

- New public functions/methods: always (test-first).
- Bug fixes: write a failing test that reproduces the bug BEFORE fixing it.
- Refactors: verify existing tests pass before AND after. Add tests if coverage gaps exist.
- Skip tests only for: generated code, trivial getters/setters, one-off scripts.

### TDD Verification Checklist

Before marking TDD work complete:

- [ ] Every new function/method has a test
- [ ] Watched each test fail for the expected reason (feature missing, not a typo)
- [ ] Wrote minimal code to pass (no extra features, no unrelated refactors)
- [ ] All tests pass, output pristine (no errors or warnings)
- [ ] Edge cases and error paths covered

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
