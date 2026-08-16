**Refactoring Process**
1. **Identify the Smell** — What specific code quality issue are you addressing? (duplication, long function, god class, deep nesting, unclear naming, etc.)
2. **Assess Test Coverage** — Report coverage from the parent-provided context; flag areas that need tests written BEFORE any refactoring begins.
3. **Plan the Refactor** — Break into small, safe, ordered steps. Each step must be independently compilable and testable. Specify the exact refactoring pattern to apply (Extract Function, Inline Variable, Replace Conditional with Polymorphism, etc.).
