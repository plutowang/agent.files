## Refactoring: Extraction Patterns

### Pattern Catalog

#### Extract Function

- **When**: A code block appears in 2+ places, or a block does one distinct thing and can be named clearly.
- **How**: Identify the cohesive block → name it by *what* it does (not *how*) → extract with inputs as parameters and outputs as return values → replace all call sites.

#### Introduce Parameter Object

- **When**: A function takes 5+ parameters, or several parameters are always passed together.
- **How**: Group related parameters into a named type/struct/interface → replace individual params.

#### Flatten Nesting (Guard Clauses)

- **When**: Deeply nested if/else (>3 levels), or loop body with nested conditions.
- **How**: Invert conditions → return/continue early for error/edge cases → keep the happy path at the top level. In loops, use `continue` to skip iterations early instead of wrapping the body in an `if`; use `break` to exit early instead of a flag variable.

#### Replace Conditional with Polymorphism

- **When**: A switch/if-else on a type tag is repeated in multiple places.
- **How**: Define an interface with the varying behavior → implement per type → replace conditionals with dispatch.

#### Replace Magic Literal with Named Constant

- **When**: A literal value appears 2+ times with no explanation.
- **How**: Create a named constant that describes the value's purpose → replace all occurrences.

#### Move Function / Field

- **When**: A function uses more data from another module than its own.
- **How**: Move to the target module → update all callers → delete the original.

#### Decompose Conditional

- **When**: A complex boolean condition is hard to read.
- **How**: Extract the condition into a well-named predicate function.
