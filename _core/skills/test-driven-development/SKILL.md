---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
---

# Test-Driven Development

Announce at the start: "I'm using the TDD skill. Enforcing TDD Iron Law."

## Core Principle

**No production code without a failing test first.** If you didn't watch the test fail, you don't know if it tests the right thing.

## Enforcement

All TDD doctrine — Red-Green-Refactor cycle, rationalizations, red flags, when-stuck guidance, and the verification checklist — lives in the testing standards. This skill enforces those standards; it does not restate them.

1. **Code before test → delete it and start over.** Don't keep it as reference, don't adapt it. Delete means delete.
2. **Test passes on first run → wrong test.** You tested existing behavior. Fix the test, then re-run until it fails for the right reason.
3. **Any rationalization → red flag.** "Just this once", "too simple", "already spent hours" — the testing standards list them all. Every one means: restart with TDD.

## Bug Fixes

Bug found? Write a failing test reproducing it BEFORE fixing. The test proves the fix and prevents regression.

## Final Rule

Production code → test exists and failed first. Otherwise → not TDD.
