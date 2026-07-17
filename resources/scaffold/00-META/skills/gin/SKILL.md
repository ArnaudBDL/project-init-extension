# Gin

## Purpose

This skill defines the mandatory engineering rules for Gin work in this project.

## Role in This Project

Gin is the selected Go HTTP web framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Keep handlers thin and dependency-injected.
- Use binding with explicit validation.
- Propagate request context to downstream services.
- Register middleware in deliberate order.
- Return consistent error responses.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not store request-specific data in global variables.
- Do not trust bound input without validation.
- Do not leak internal errors in HTTP responses.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Gin code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
