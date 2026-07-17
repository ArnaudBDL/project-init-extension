# Go Standard Library

## Purpose

This skill defines the mandatory engineering rules for Go Standard Library work in this project.

## Role in This Project

Go Standard Library is the selected Go HTTP and service implementation using the standard library. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use net/http handlers with explicit dependencies.
- Propagate context through request-scoped operations.
- Set server timeouts explicitly.
- Use encoding packages with validated boundary types.
- Keep middleware small and composable.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not use the default global HTTP client without timeout control.
- Do not retain request contexts after request completion.
- Do not place domain logic directly in handlers.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Go Standard Library code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
