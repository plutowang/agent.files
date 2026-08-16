**Philosophy**
- Tests document intent — answer: "what behavior does this protect?"
- Prefer **integration tests** for business logic; unit tests for pure functions and edge cases.
- Never mock what you don't own — wrap external dependencies behind interfaces, then mock the interface.
**Test Structure**
- Follow **Arrange → Act → Assert** (AAA); one logical assertion per test — test one behavior, not one function.
- Test names describe scenario + expected outcome: `should_return_404_when_user_not_found`.
**Coverage & Priority**
- Target **80% minimum coverage** on critical paths (authentication, payment, data mutations) — don't chase 100%; diminishing returns past 85%.
- Coverage is a metric, not a goal — untested edge cases matter more than high percentages.
**Table-Driven Tests**
- When testing the same logic with multiple inputs, use parameterized/table-driven tests to reduce duplication.
