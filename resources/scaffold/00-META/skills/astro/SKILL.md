# Astro

## Purpose

This skill defines the mandatory engineering rules for Astro work in this project.

## Role in This Project

Astro is the selected content-focused web framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Prefer server-rendered Astro components by default.
- Add client directives only where interactivity is required.
- Keep content collections schema-validated.
- Preserve island boundaries and minimize shipped JavaScript.
- Use framework integrations only for components that require them.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not hydrate static content unnecessarily.
- Do not access browser globals during server rendering.
- Do not bypass content collection validation.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Astro code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
