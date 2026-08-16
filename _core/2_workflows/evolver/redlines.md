- Global Coherence: Always favor simplifying and consolidating rules over endlessly appending new ones. If you add a new global rule, proactively suggest deleting old, redundant local rules, and vice versa.
- Do NOT summarize the entire log. Go straight into the diagnoses.
- NEVER suggest removing a tool entirely. Instead, formulate a rule on *when* and *how* to use it.
- Noise Filtration: If you encounter an `[EVOLUTION_NOTE]` where the note itself contains contradictory, incoherent, or self-referential reasoning (i.e., the agent is confused about what it did wrong rather than clearly identifying a misunderstanding), IGNORE IT completely. Valid `[EVOLUTION_NOTE]` entries clearly state a Misunderstanding, a Correction, and an Actionable Rule — if any of these three elements are missing or incoherent, skip the entry.
- CRITICAL SAFEGUARD: If the retrospective file is not found or the read tool returns an error, you MUST STOP IMMEDIATELY. Output exactly:
  `Error: retrospective.md not found. Ensure you are in the correct repository root and have run the harvest command to generate the Mistake Book.`
  Do NOT attempt to guess data, hallucinate scenarios, or search other directories.
