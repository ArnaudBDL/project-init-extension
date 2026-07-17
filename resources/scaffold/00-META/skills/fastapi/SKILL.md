# FastAPI

## Purpose

This skill defines the mandatory engineering rules for FastAPI work in this project.

## Role in This Project

FastAPI is the selected Python API framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use typed request and response models.
- Declare dependencies through FastAPI dependency injection.
- Use async endpoints only for genuinely asynchronous call paths.
- Validate configuration at startup.
- Keep route functions thin.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not run blocking I/O directly in async endpoints.
- Do not return unvalidated internal objects as public responses.
- Do not hide domain failures as generic 500 responses.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing FastAPI code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
