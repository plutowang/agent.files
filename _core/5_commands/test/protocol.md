**Process**
0. **Invariant ⏸ (IV) exception** — This command generates characterization tests for code that already exists. Writing tests here is the command's purpose, not a test-after violation. Do not modify production code in this command; any production-code change follows RED-first discipline separately.
1. Identify all public functions, methods, and edge cases.
2. Generate tests using the Arrange → Act → Assert pattern.
3. Include both happy-path and failure-mode coverage.
4. Use table-driven tests when testing the same logic with multiple inputs.
5. ⏸ (I) Present the proposed test plan to the user before writing any test files.
