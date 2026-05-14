---
name: angular
description: Auto-apply when working with Angular. Trigger this skill when the user asks to create, modify, or debug Angular components, services, directives, pipes, HTML templates, or run Angular CLI commands.
---

# Angular & Nx Stack Expert

You are an expert in **Modern Angular (v19+)**. You strictly adhere to the latest syntax features and reactive patterns.

## Template Standards

1. **Control Flow**: Use `@if`, `@for`, `@switch`, `@case`. No `*ngIf`, `*ngFor`, `ngSwitch`.
2. **Variables**: Use `@let` for template vars. Avoid `*ngIf="obs$ | async as val"` aliases.
3. **Reactivity**: Use `*ngrxLet` for Observables. Import `LetDirective` in components.

## Styling

- Tailwind CSS only. No component `.scss` or `.css` files.
- Use `styles: []` and utility classes in templates.

## Project Layout

- Use `skill nx-monorepo` if `nx.json` exists.
- Standard layout uses `src/app/`.

## Tooling

- Package Manager: `pnpm`
- Generator: `pnpm nx g ...` (Nx) or `pnpm ng g ...` (standard)
- Run: `pnpm nx serve <app>` (Nx) or `pnpm start` (standard)
- Format: `pnpm nx format:write` (Nx) or `pnpm format:write` (standard)

## Component Architecture

- **Standalone**: All components must be `standalone: true`.
- **Signals**: Always use `input()`, `output()`, `viewChild()` signal functions — never `@Input()`, `@Output()`, `@ViewChild()` decorators.
- **Reactivity**: Use `computed()` for derived values and `effect()` for side effects. Keep `constructor()` empty when possible — use `private _ = effect(() => { ... })` as a field initializer for setup logic instead. The `effect()` runs within injection context and auto-cleans up on component destroy.
- **Template Performance**: Never invoke functions directly in template bindings. Function calls in templates trigger on every change detection cycle, degrading performance. When a value needs transformation, create an Angular `Pipe` (standalone, `pure: true`) and use it in the template instead.
- **Unsubscribing**: Use `takeUntilDestroyed()` to automatically complete Observable subscriptions when the component/directive is destroyed. Inject `DestroyRef` when calling outside an injection context, or omit the argument inside `constructor()` or field initializers where it is inferred automatically.

**Docs**: Context7 `/websites/angular_dev` · Fallback: <https://angular.dev>
