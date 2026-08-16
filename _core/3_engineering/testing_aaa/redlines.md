- **NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.** Write code before a test? Delete it. Start over.
- **Violating the letter is violating the spirit.** "Tests after achieve the same result" is not a technical argument — it is rationalization. A test that never failed proves nothing.
- Red Flags — Stop and Restart — any of these means: delete the code and restart with TDD.
- Production code written before a test; test passes on first run (you tested existing behavior).
- Can't explain why the test failed; rationalizing "just this once".
- Tests added after implementation "to catch up".
**Rationalizations (Do Not Use)**
- "Too simple to test" — Simple code breaks. Test takes seconds.
- "I'll test after" / "Tests after do the same" — Tests-after verify only the code you remembered to check; passing immediately proves nothing.
- "Already manually tested" / "Manual test is faster" — Manual testing is ad-hoc: no record, can't be re-run, proves no edge cases.
- "Deleting code is wasteful" — Sunk cost fallacy. Untested code is technical debt.
- "Need to explore first" / "Keep it as reference" — Throw away exploration; keeping pre-test code is testing after. Delete means delete.
- "TDD will slow me down" — Debugging without tests is slower than TDD.
- "Existing code has no tests" — You are improving it — start with the new code.
**Anti-Patterns to Avoid**
- Tests that test the implementation rather than behavior; flaky tests dependent on timing, network, or filesystem state.
- Snapshot tests for anything other than serialized output (never for UI components); test files that import directly from external packages or services.
