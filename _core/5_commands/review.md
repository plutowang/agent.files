## Process

**HARD GUARDRAIL: NEVER modify, create, or delete any files.** This command runs in agents that may have write permissions (build, design). Review is read-only — produce a report, never patches.

### Step 1: Determine the Base Branch

If the user specified: `/review against <branch>` — use `<branch>` as the base.

If the user ran `/review` (no argument), auto-detect the default branch:

```bash
for branch in main master; do
  if git merge-base --is-ancestor origin/$branch HEAD 2>/dev/null; then
    echo $branch
    break
  fi
done
```

Fall back to `main` if detection fails.

### Step 2: Gather Requirements Context

Fetch linked requirements from the issue tracker.

**If the repo is on GitLab** and MCP tools are available:

- Load and follow `_core/2_workflows/gitlab_context.md` to fetch the MR, linked issues, blocked/blocking issues, and epics.
- This produces a requirements block (or confirms no context was found).

**Otherwise:**

- Ask: "Paste requirements or skip (code-only review)?"
- If pasted: use as the requirements block.
- If skipped: proceed without requirements.

### Step 3: Get the Code Diff

```bash
MERGE_BASE=$(git merge-base origin/$BASE_BRANCH HEAD)
git log --oneline $MERGE_BASE..HEAD
git diff $MERGE_BASE..HEAD
```

Include uncommitted changes: `git diff --cached` and `git diff`.

### Step 4: Review

Load the `code-review` skill.

Evaluate changes along two independent axes per the engineering standard:

**Axis 1 — Standards** (delegated to `code-review` skill):

- The skill handles correctness, security, performance, types, and quality.
- Do not restate its process here.

**Axis 2 — Spec** (handled here, when requirements are available):

- For each requirement: does the diff implement it? Quote the requirement, cite matching code (file:line).
- Any requirements missing or partially implemented?
- Any code in the diff not asked for by any requirement? (scope creep)
- **Dependencies**: if blocked issues specify prerequisites, are they satisfied?
- **Follow-ups**: will the blocking issues fit on top of this implementation, or will they need rework?
- Quote the issue line for each finding.

If requirements are unavailable, report only the Standards axis.

### Step 5: Report

Categorize findings by severity (Critical / Warning / Suggestion) with file:line references.

If security concerns are found, delegate to the `security-reviewer`.

End with a verdict: **Approved** / **Approved with suggestions** / **Changes requested**.

<!-- @import _core/2_workflows/gitlab_context.md -->
<!-- @import _core/3_engineering/code_review.md -->
<!-- @import _core/3_engineering/code_standards.md -->
