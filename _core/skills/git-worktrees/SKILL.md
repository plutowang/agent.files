---
name: git-worktrees
description: Load before starting implementation on a feature branch. Creates or verifies an isolated git worktree for the current task.
---

# Git Worktrees: Isolated Workspaces

Create an isolated working directory for the current feature using git worktrees. This keeps work in progress separate from the main working tree.

## Detection

Check if already in a worktree: if `GIT_COMMON_DIR` is set and differs from `GIT_DIR`, you are in an isolated worktree. Otherwise, create one.

## Creating a Worktree

1. Determine the base branch (default: `main`)
2. Create a new worktree under `.worktrees/<feature-name>`
3. Navigate into the isolated worktree for all subsequent work

```bash
git worktree add .worktrees/<feature-name> -b <branch-name> main
```

## Cleanup

When feature work is complete and merged, remove the worktree:

```bash
git worktree remove .worktrees/<feature-name>
```

## Principles

- Always work in an isolated worktree for multi-task features
- Never start implementation on main/master without explicit human consent
- The worktree keeps your main working tree clean and free from partial changes
