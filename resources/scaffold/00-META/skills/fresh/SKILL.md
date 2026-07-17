# Fresh

## Purpose

This skill defines the mandatory engineering rules for Fresh work in this project.

## Role in This Project

Fresh is the selected Preact web framework for Deno. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Keep routes server-rendered by default.
- Use islands only for interactive UI.
- Use Deno-compatible modules and project-pinned imports.
- Keep handlers thin and validate request input.
- Preserve zero-client-JavaScript behavior for static content.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not turn whole pages into islands.
- Do not introduce Node-only dependencies without verified Deno support.
- Do not ship client JavaScript for non-interactive content.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Fresh code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
