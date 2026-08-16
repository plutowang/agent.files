**Step 1: Determine the Base Branch**
If the user specified: `/review against <branch>` — use `<branch>` as the base.
If the user ran `/review` (no argument), auto-detect the default branch:

```bash
for b in main master; do git merge-base --is-ancestor origin/$b HEAD 2>/dev/null && { echo $b; break; }; done
```

Fall back to `main` if detection fails.
**Step 2: Gather Requirements Context**
Fetch linked requirements from the issue tracker.
**If the repo is on GitLab** and MCP tools are available:

- Follow the GitLab requirements pipeline below (steps A–G) — it produces a requirements block (or confirms no context was found).
**Otherwise:**
- Ask: "Paste requirements or skip (code-only review)?" If pasted: use as the requirements block; if skipped: proceed without requirements.
**Step 3: Get the Code Diff**

```bash
M=$(git merge-base origin/$BASE_BRANCH HEAD); git log --oneline $M..HEAD; git diff $M..HEAD
```

Include uncommitted changes: `git diff --cached` and `git diff`.
**Step 4: Review**
Load the `code-review` skill.
Evaluate changes along two independent axes per the engineering standard:
**Axis 1 — Standards** (delegated to `code-review` skill):
- The skill handles correctness, security, performance, types, and quality. Do not restate its process here.
**Axis 2 — Spec** (handled here, when requirements are available):
- For each requirement: does the diff implement it? Quote the requirement, cite matching code (file:line).
- Requirements missing or partially implemented?
- Code in the diff not asked for by any requirement? (scope creep)
- **Dependencies**: are prerequisites from blocked issues satisfied?
- **Follow-ups**: will blocking issues fit on top, or need rework?
- Quote the issue line for each finding.
If requirements are unavailable, report only the Standards axis.
**Step 5: Report**
Categorize findings by severity (Critical / Warning / Suggestion) with file:line references.
If security concerns are found, delegate to the dedicated security review agent.
End with a verdict: **Approved** / **Approved with suggestions** / **Changes requested**.
<!-- @import _core/2_workflows/gitlab_context/protocol.md -->
