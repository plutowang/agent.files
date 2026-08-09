---
name: code-review
description: Use when asked to review a branch, Pull Request (PR), Merge Request (MR), inline code snippet, or perform a pre-merge review. Covers full branch reviews and lightweight snippet critique.
license: MIT
---

# Code Review

Perform comprehensive code reviews of a branch against the base branch, providing actionable feedback on code quality, security, performance, and best practices.

## When to Use This Skill

Activate this skill when:

- The user types "review", "code review", "critique", or "analyze"
- The user types "review BRANCH-NAME" to review a specific branch
- The user asks to review a specific code snippet, function, or file
- The user asks to review a branch, pull request, or merge request
- Analyzing code changes before merging
- Performing code quality assessments
- Checking for security vulnerabilities or performance issues
- Reviewing branch diffs

**Three Review Modes:**

1. **Snippet Review** — review a specific code block or snippet for bugs, security issues, and code quality
2. **Current Branch Review** (default when no branch specified)
   - Reviews all changes in current branch (committed + uncommitted)
   - Includes staged and unstaged changes
   - Runs automated checks (linters, formatters, tests)

3. **Other Branch Review** (when branch name specified)
   - Uses git worktree for non-disruptive review
   - Reviews only committed changes from that branch
   - Leaves your current work untouched

## Snippet Review Mode

When reviewing a code snippet rather than a full branch, focus on:

- **Security**: Injections, exposed secrets, unsanitized input.
- **Performance**: O(n²) loops, memory leaks, unoptimized queries.
- **Types**: Strict typing (no `any`), correct error handling.
- **Logic**: Edge cases, off-by-one errors, incorrect assumptions.

Output findings in three tiers:

- 🔴 **Critical** — Bugs, security vulnerabilities, panics.
- 🟡 **Warning** — Performance issues, messy logic, missing error handling.
- 🟢 **Suggestion** — Naming, formatting, style improvements.

For each finding, include the file and line reference, frame it as a question (e.g., "Could this cause X?"), and provide a corrected example only if requested. Do not review the full branch — this mode is for the provided snippet only.

## Branch Selection

### Branch Name Provided

When a branch name is given, use `skill git-worktrees` for isolated workspace setup. Fetch latest, create the worktree, and perform all review operations within it. Clean up the worktree after the review.

### No Branch Specified (Current Branch)

Review the current branch in place:

1. **Include uncommitted changes**:
   - Staged changes: `git diff --cached`
   - Unstaged changes: `git diff`
2. **Run automated quality checks** (linters, formatters, tests)
3. Do not create a worktree or switch branches

## Analyze Branch Context

First, gather essential information about the branch to review:

- Identify the current branch name (or worktree branch)
- Determine the appropriate base branch (main or master)
- Check for any uncommitted changes (current branch only)
- **Find the merge-base** to isolate only commits made in this branch
- Get the list of commits and changed files

### Detect Default Branch (Use Ancestry)

```bash
DEFAULT_BRANCH=""

for branch in main master; do
  if git merge-base --is-ancestor origin/$branch HEAD 2>/dev/null; then
    DEFAULT_BRANCH=$branch
    break
  fi
done

if [ -z "$DEFAULT_BRANCH" ]; then
  DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
fi

if [ -z "$DEFAULT_BRANCH" ]; then
  if git show-ref --verify --quiet refs/remotes/origin/main; then
    DEFAULT_BRANCH="main"
  elif git show-ref --verify --quiet refs/remotes/origin/master; then
    DEFAULT_BRANCH="master"
  fi
fi

[ -z "$DEFAULT_BRANCH" ] && DEFAULT_BRANCH="main"
```

### Finding Branch-Specific Changes (CRITICAL)

**You MUST use `git merge-base` to find the common ancestor.** This ensures you only review commits that were made in THIS branch, not commits from other branches that happened to be merged into main.

```bash
MERGE_BASE=$(git merge-base origin/$DEFAULT_BRANCH HEAD)
git log --oneline $MERGE_BASE..HEAD
git diff --name-status $MERGE_BASE..HEAD
git diff $MERGE_BASE..HEAD
```

**Why this matters:**

- `git diff origin/main..HEAD` shows ALL differences between main and HEAD, which includes changes from OTHER branches that were merged into main after this branch was created
- `git diff $(git merge-base origin/main HEAD)..HEAD` shows ONLY the changes introduced in THIS branch

**Always use the merge-base approach for:**

- `git log` - to list commits
- `git diff` - to see changes
- `git diff --stat` - for change statistics
- `git diff --name-status` - for file list

### Uncommitted Changes (Current Branch Only)

```bash
git diff --cached --name-status
git diff --cached --stat
git diff --name-status
git diff --stat
```

### Exclude Lock Files

Do not review lock files. Filter them out:

- `pnpm-lock.yaml`
- `package-lock.json`
- `yarn.lock`
- `bun.lockb`
- `go.sum`
- `Cargo.lock`
- `poetry.lock`
- `Pipfile.lock`
- `pdm.lock`
- `Gemfile.lock`
- `composer.lock`
- `deno.lock`
- `flake.lock`

### Large Diff Confirmation

If diff is very large, ask for confirmation before proceeding:

- **Files > 100** or **Lines > 5000**

## Run Automated Quality Checks

**Current branch**: Always run checks.
**Worktree**: Ask the user before running checks (may require installing dependencies).

Auto-detect project type and run appropriate checks. Use `gtimeout` or `timeout` with a 5-minute limit per check. Failures are reported but do not stop the review.

### Detect Project Type

```bash
# Detect in order of specificity
if [ -f "nx.json" ]; then
  PROJECT_TYPE="nx"
elif [ -f "Cargo.toml" ]; then
  PROJECT_TYPE="rust"
elif [ -f "go.mod" ]; then
  PROJECT_TYPE="go"
elif [ -f "package.json" ]; then
  PROJECT_TYPE="node"
else
  PROJECT_TYPE="unknown"
fi
```

### Run Checks by Type

```bash
# Nx (Node.js/TypeScript monorepo)
pnpm nx run-many --target=lint,test --target=test --parallel=2

# Rust
cargo clippy --all-targets --all-features -- -D warnings
cargo check --all
cargo fmt --check --all
cargo test

# Go
go vet ./...
go test -v ./...

# Node.js (pnpm)
pnpm lint
pnpm test

# Node.js (npm/yarn fallback)
npm run lint 2>/dev/null || yarn lint 2>/dev/null
npm test 2>/dev/null || yarn test 2>/dev/null
```

Capture output and include results in the review report.

## Perform Comprehensive Code Review

Conduct a thorough review of **only the changes introduced in this branch** (using merge-base as described above).

### 1. Change Analysis

- Use `git diff $(git merge-base origin/$DEFAULT_BRANCH HEAD)..HEAD -- <file>` to review each modified file
- **If reviewing current branch**: Also review `git diff --cached` and `git diff`
- Examine commits using `git show <commit-hash>` for individual commits in the branch
- Identify patterns across changes
- Check for consistency with existing codebase
- **Only comment on code that was changed in THIS branch's commits or uncommitted work**

### 2. Code Quality Assessment

- Code style and formatting consistency
- Variable and function naming conventions
- Code organization and structure
- Adherence to DRY (Don't Repeat Yourself) principles
- Proper abstraction levels

### 3. Technical Review

- Logic correctness and edge cases
- Error handling and validation
- Performance implications
- Security considerations (input validation, SQL injection, XSS, etc.)
- Resource management (memory leaks, connection handling)
- Concurrency issues if applicable

### 4. Best Practices Check

- Design patterns usage
- SOLID principles adherence
- Testing coverage implications
- Documentation completeness
- API consistency
- Backwards compatibility

### 5. Dependencies and Integration

- New dependencies added
- Breaking changes to existing interfaces
- Impact on other parts of the system
- Database migration requirements

## Generate Review Report

Create a structured code review report with:

1. **Executive Summary**: High-level overview of changes and overall assessment
2. **Statistics**:
   - Files changed, lines added/removed
   - Commits reviewed
   - Uncommitted changes status (current branch only)
   - Critical issues found
3. **Automated Check Results**:
   - Format check: ✅ Passed / ❌ Failed
   - Linter: ✅ Passed / ⚠️ Warnings / ❌ Errors
   - Tests: ✅ Passed / ❌ Failed
   - Brief summary of failures
4. **Strengths**: What was done well
5. **Issues by Priority** (vocabulary matches the code review standards: Critical / Warning / Suggestion):
   - 🔴 **Critical**: Must fix before merging (bugs, security issues, failed checks)
   - 🟡 **Warning**: Should address (performance, maintainability)
   - 🟢 **Suggestion**: Nice to have improvements
6. **Detailed Findings**: For each issue include:
   - File and line reference
   - A question framing the concern (e.g., "Could this cause X?" or "Would it help to Y?")
   - Context explaining why you're asking
   - Code example if helpful
7. **Security Review**: Specific security considerations
8. **Performance Review**: Performance implications
9. **Testing Recommendations**: What tests should be added
10. **Documentation Needs**: What documentation should be updated

### Report Output

1. Display the complete review report in markdown format
2. Save report to `CODE_REVIEW_[YYYY-MM-DD_HH-MM-SS].md` in repo root

Example filename: `CODE_REVIEW_2026-01-27_14-30-22.md`

## User Interaction

After completing the review:

1. Display the complete review report in markdown format
2. Provide actionable next steps based on findings
3. If critical issues found, highlight them prominently

## Feedback Style: Questions, Not Directives

**Frame all feedback as questions, not commands.** This encourages dialogue and respects the author's context.

### Examples

❌ **Don't write:**

- "You should use early returns here"
- "This needs error handling"
- "Extract this into a separate function"
- "Add a null check"

✅ **Do write:**

- "Could this be simplified with an early return?"
- "What happens if this API call fails? Would error handling help here?"
- "Would it make sense to extract this into its own function for reusability?"
- "Is there a scenario where this could be null? If so, how should we handle it?"

### Why Questions Work Better

- The author may have context you don't have
- Questions invite explanation rather than defensiveness
- They acknowledge uncertainty in the reviewer's understanding
- They create a conversation rather than a checklist
