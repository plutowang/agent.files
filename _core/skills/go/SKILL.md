---
name: go
description: Auto-apply when working with Go (Golang). Trigger this skill when the user asks to create, modify, or debug Go code, HTTP handlers, middleware, CLI tools, or Go tests.
---

# Lang: Go

## Rules

1. **Errors:** Wrap with `fmt.Errorf("...: %w", err)`. Never ignore.
2. **Context:** `ctx context.Context` MUST be 1st arg.
3. **DB:** Use **SQLBoiler** models/executors. NO GORM/Raw SQL.
4. **Tests:** Table-Driven (`struct` slice) + `testify/require`.
5. **Layout:** Use `skill nx-monorepo` if `nx.json` exists. Otherwise use standard `cmd/`, `internal/`, `pkg/`.
6. **Libs:** Log=`log/slog`, Conc=`errgroup`.

## Workflow

- Use `skill workflow-env` before build/run commands.
- Build: `go build ./cmd/<app>`
- Test: `go test -v ./...`
- Format: `gofmt -w .`

**Docs**: Context7 `/golang/go` · Fallback: <https://go.dev/doc>
