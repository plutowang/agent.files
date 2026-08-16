**Named Smell Catalog**

Recognize these classic smells (Fowler) by name so they can be flagged in reviews:

| Smell | What it looks like | Typical fix |
| --- | --- | --- |
| **Mysterious name** | Identifier doesn't say what it does | Rename |
| **Duplicated code** | Same logic in two places | Extract once |
| **Long function** | >50 lines, multiple responsibilities | Decompose |
| **Long parameter list** | 4+ parameters | Group into a struct |
| **Feature envy** | Method reaches into another object's data | Move the behavior |
| **Data clumps** | Same data trio passed around together | Introduce a value object |
| **Primitive obsession** | Using strings/numbers for a concept | Introduce a type |
| **God object** | One class/module does everything | Split by responsibility |
| **Shotgun surgery** | One change touches many files | Move logic together |
| **Speculative generality** | Abstraction for a future that never came | Delete it (YAGNI) |
