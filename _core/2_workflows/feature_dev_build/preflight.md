Before claiming any task complete:

- [ ] Code compiles and type-checks cleanly
- [ ] Existing tests still pass
- [ ] New behaviour has tests ⏸ (IV)
- [ ] No credentials, secrets, or keys introduced ⏸ (V)
- [ ] Error cases handled — no bare throws, no swallowed errors
- [ ] No debug statements left behind
- [ ] `verification-gate` self-gate satisfied first — never optional; the `verifier` is a separate, independent second opinion, not a replacement.
