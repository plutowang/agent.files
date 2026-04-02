## Git Workflow

### Conventional Commits

- Follow the Conventional Commits specification: `type(scope): description`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`
- Scope is optional but encouraged for monorepos.
- Description is imperative mood, lowercase, no period: `feat(auth): add JWT refresh token rotation`

### Atomic Commits

- One logical change per commit. Don't mix refactoring with feature work.
- Each commit should leave the codebase in a compilable, testable state.
- If a change requires multiple steps, each step gets its own commit.

### Safety Rules

- **Never force-push to main/master.** Period.
- **Never commit secrets**, credentials, API keys, `.env` files, or private keys — even temporarily.
- **Never amend commits** that have been pushed to remote.
- **Verify tests pass** before creating a commit.
- **Review the diff** before committing — no accidental files, no debug statements.

### Branch Strategy

- Feature branches from main: `feat/description` or `fix/description`.
- Keep branches short-lived — merge within days, not weeks.
- Rebase feature branches on main before merging to maintain linear history.

### Pull Requests

- Title follows conventional commit format.
- Description includes: summary (1-3 bullets), what changed, how to test.
- Link related issues.
- Keep PRs focused — one feature or fix per PR.
