# Analog

## Purpose

This skill defines the mandatory engineering rules for Analog work in this project.

## Role in This Project

Analog is the selected Angular meta-framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Follow Angular standalone conventions.
- Use file-based routing according to the project route structure.
- Keep server-only and browser-only code separated.
- Use framework data-loading primitives consistently.
- Preserve SSR and prerendering compatibility.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not duplicate routes outside the file-based routing source.
- Do not access browser APIs in server execution paths.
- Do not bypass Angular dependency injection conventions.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Analog code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
