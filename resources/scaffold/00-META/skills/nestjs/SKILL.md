# NestJS

## Purpose

This skill defines the mandatory engineering rules for NestJS work in this project.

## Role in This Project

NestJS is the selected Node.js application framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use modules to define clear capability boundaries.
- Use dependency injection instead of manual service construction.
- Validate DTOs at transport boundaries.
- Keep controllers thin and services focused.
- Use guards, interceptors and filters for their intended cross-cutting concerns.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not create circular module dependencies.
- Do not place domain logic in controllers.
- Do not bypass configured validation pipes.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing NestJS code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
