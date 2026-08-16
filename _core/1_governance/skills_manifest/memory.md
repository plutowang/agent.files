Load relevant skills before starting work:

- `aws` — AWS infrastructure or services
- `react` — React components or hooks
- `angular` — Angular modules, components, or services
- `go` — Go source files
- `rust` — Rust source files
- `zig` — Zig source files
- `csharp` — C# / .NET source files
- `graphql` — GraphQL schemas or resolvers
- `rest-api` — Designing or reviewing REST endpoints, resource naming, status codes, pagination, idempotency
- `workflow-env` — Auto-apply before any build, test, or run command. Validates and sources env.sh
- `git` — Git version control — commit, branch, merge, rebase, and recovery workflows
- `code-review` — Branch, PR, or inline code snippet review
- `diagnosing-bugs` — Disciplined 6-phase diagnosis loop for hard bugs and performance regressions
- `domain-modeling` — Build and sharpen a project's domain model, glossary, and architectural decisions
- `privacy-guard` — Files that may contain secrets or PII
- `research` — Investigates topics against primary sources with cited findings
- `nx-monorepo` — Nx workspace operations
- `brainstorming` — Pre-code design phase. One-question-at-a-time, saves spec, presents approaches
- `git-worktrees` — Decide whether an isolated workspace is needed before implementation
- `writing-plans` — Granular task planning with exact code, paths, and verification
- `subagent-driven-dev` — Delegated task-by-task execution with two-stage review (spec then quality)
- `verification-gate` — No completion claims without fresh verification evidence
- `test-driven-development` — Write tests first, watch them fail, then implement minimal code. No production code without a failing test.
- `receiving-code-review` — Use when receiving code review feedback. Verify before implementing. No performative agreement.
- `writing-for-agents` — Reference for writing skill files and any document an agent consumes

Design-phase and execution-phase skills are scoped to their phase — if a skill will not load, you are outside its phase and should not be using it.
