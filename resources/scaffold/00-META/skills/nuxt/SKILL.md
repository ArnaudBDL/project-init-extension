# Nuxt

## Purpose

This skill defines the mandatory engineering rules for Nuxt work in this project.

## Role in This Project

Nuxt is the selected Vue application framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use Nuxt directory conventions and auto-import rules consistently.
- Keep server routes and client code separated.
- Use Nuxt data-fetching primitives for page data.
- Preserve SSR-safe component behavior.
- Use runtime configuration for environment-dependent values.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not expose private runtime configuration to the client.
- Do not access browser APIs during server rendering.
- Do not duplicate Nuxt-managed imports and routing configuration.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Nuxt code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
