---
name: rust
description: Auto-apply when working with Rust. Trigger this skill when the user asks to create, modify, or debug Rust code, Cargo projects, crates, or Rust tests.
---

# Lang: Rust

## Rules

1. **Safety:** NEVER use `.unwrap()`. Use `?` propagation or `.expect("msg")`.
2. **Style:** Prefer **Iterators** (`.map().collect()`) over `for` loops.
3. **Async:** Assume `tokio`. Use `.await`. Never block async threads.
4. **Errors:** Use `anyhow::Result` for apps, `thiserror` for libs.
5. **Tests:** Co-locate unit tests in `mod tests` with `#[cfg(test)]`.
6. **Clippy:** Code must be strictly `clippy`-compliant (idiomatic).

## Workflow

- Use `skill workflow-env` before build/run commands.
- Build: `cargo build --release`
- Test: `cargo test`
- Format: `cargo fmt`

**Docs**: Context7 `/websites/doc_rust-lang_stable_book` · Fallback: <https://doc.rust-lang.org>
