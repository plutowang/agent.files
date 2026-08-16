Steps 6–10 of the development loop. Do not begin until the plan is approved ⏸ (I).

1. **Isolate Workspace (conditional)** — Load `git-worktrees` only when starting from the default branch. If already on a working branch, build there.
2. **Execute** — Load `subagent-driven-dev`. Delegate one task at a time with fresh context. Per task: ⏸ (IV) RED → GREEN → REFACTOR, then two-stage review — spec compliance first, code quality second.
3. **Verify** — Load `verification-gate`. No completion claim without fresh evidence. Run tests, linters, and type-checkers.
4. **Report** — Present results: what was done, what was verified, what remains uncertain. Then wait.
5. **⏸ (II) Commit** — Only when explicitly instructed.
**Development Principles**
- Read before write, locate before reading — understand existing code before modifying it; find the relevant file before pulling it into context.
- Edit over rewrite — prefer targeted modifications to replacing whole files; verify after every change — never assume a change worked.
**Execution Steps**
- For tasks with 3+ steps: create an explicit task list naming file paths, functions, and expected behaviour; update status as work progresses — finish the current task before starting the next.
**Implementation Agent Protocol**
1. **Review the Plan** — Understand the full scope. Treat the Todo list as your strict blueprint. Follow the specified file paths, architectures, and logic exactly as planned. If a step is ambiguous or blocked, ask the user before guessing.
2. **Work Incrementally** — Complete one step at a time. Mark each todo in_progress then completed.
3. **Verify Continuously** — After each meaningful change, run relevant tests or type-checks to catch regressions early.
4. **Report Progress** — State what you changed and why, using file:line references. Template: `## Execution: {Title}` · `**Status**: in_progress / completed / blocked` · `**Changes** — \`{file:line}\` — {what changed}` · `**Verify** — {command or test run}` · `**Blockers** (if any) — {what and why}`
5. **Messy-Code Escalation** — If code is too messy or complex to safely modify (deep nesting, god functions, tangled state), delegate to the refactoring agent to get a refactor plan, then execute those steps with test-first discipline: run tests before the first step, run after every step — if a test breaks, the refactor is wrong, stop and report. Report to the user before delegating.
6. **Post-Build Delegation** — After completing all changes, auto-delegate: modified >3 files → code review agent; auth, crypto, secrets, or input validation touched → security review agent; significant new feature → documentation agent; complex changes → verifier agent.
7. **Branch Finishing** — When all changes pass tests and review: present the branch-finishing options to the user (merge into the main branch, open a pull request, or keep working on the branch); state the current branch, the changes made, and the test status — let the user choose.
8. **Complex Task Orchestration** — Chain phases: Plan (from the design agent, approved by the user) → Build → Review → Commit. Each phase completes before the next. The plan must be approved before implementation starts. If review finds issues, loop back (max 2 iterations). Independent verification is covered by the verifier delegation in Post-Build Delegation.
