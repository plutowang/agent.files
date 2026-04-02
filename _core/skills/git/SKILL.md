---
name: git
description: Auto-apply when the user asks for any git version control operations, including commit, push, pull, branch, merge, rebase, squash, reset, revert, cherry-pick, stash, tag, undo, amend, diff, log, or blame.
---

# Git Master (Safe Mode)

## Security Protocol

1. **NEVER EXECUTE** write commands (commit, push, rebase, reset, branch deletion).
2. **ONLY EXECUTE** read-only commands (`status`, `log`, `diff`, `branch --list`, `stash list`).
3. **ALWAYS OUTPUT** write commands in bash code blocks for the user to copy-paste and run manually.

## 1. Standards

- **Commit Format:** `<type>(<scope>): <description>`
- **Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`.
- **Branch Format:** `<type>/<kebab-case-description>` (e.g., `feat/auth-login`).

## 2. Workflows

All write commands below are **output only** — never execute them.

- **Commit:** Analyze `git diff` → output `git commit -m "type(scope): description"` for user.
- **Push:** Output `git push -u origin <branch>` for user.
- **Sync:** Output `git fetch origin && git rebase origin/main` for user.
- **Squash:**
  1. Identify count $N$ from `git log`.
  2. Output `git rebase -i HEAD~N` for user.
  3. **Instruct:** "Change `pick` to `squash` (or `s`) for the bottom $N-1$ commits."

## 3. Recovery: "Wrong Push"

Identify if branch is **Public** (shared/main) or **Private** (feature).

All recovery commands are **output only** — present them for the user to review and run manually.

### A. Public (Safe / No Force Push)

Output these commands for the user:

```bash
# 1. Undo on wrong branch
git checkout wrong && git revert <hashes> && git push
# 2. Move to right branch
git checkout right && git cherry-pick <hashes> && git push
```

### B. Private (Clean / Force Push OK)

Output these commands for the user:

```bash
# 1. Copy commits to correct branch
git checkout right && git cherry-pick <hashes>
# 2. Reset wrong branch (DESTRUCTIVE — user must confirm)
git checkout wrong && git reset --hard <good-hash> && git push -f
```

**Warning:** `git reset --hard` and `git push -f` are destructive. Always warn the user before outputting these commands.

### C. Local/Recent ("Soft Reset")

Output these commands for the user:

```bash
git reset --soft HEAD~N
git checkout right
git commit
```
