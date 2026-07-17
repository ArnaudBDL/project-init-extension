# Hono

## Purpose

This skill defines the mandatory engineering rules for Hono work in this project.

## Role in This Project

Hono is the selected portable web framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Keep runtime-specific code behind adapters.
- Use typed environment bindings.
- Validate request input at route boundaries.
- Compose middleware explicitly.
- Preserve portability across the selected deployment runtime.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not assume Node APIs in portable code.
- Do not expose environment secrets through responses.
- Do not embed domain logic in route declarations.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Hono code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
