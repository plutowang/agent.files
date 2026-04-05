---
name: create-react-form
description: Scaffolds a new React form component with validation.
agent: agent
tools: ['search/codebase']
---
Create a new React form component named `${input:formName:Enter the name of the form component}`.

The component should include basic structure, TypeScript interfaces, and form validation logic.
Analyze existing components using #tool:search/codebase to ensure stylistic consistency.

## Coding Standards
<!-- @import _core/3_engineering/code_standards.md -->