# SvelteKit

## Purpose

This skill defines the mandatory engineering rules for SvelteKit work in this project.

## Role in This Project

SvelteKit is the selected Svelte application framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use filesystem routing and load functions consistently.
- Separate universal, server-only and client-only code.
- Use form actions for server mutations when appropriate.
- Preserve SSR-safe data loading.
- Keep hooks focused on request lifecycle concerns.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not import private server modules into client code.
- Do not access browser globals during SSR.
- Do not duplicate route data fetching inside leaf components.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing SvelteKit code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
