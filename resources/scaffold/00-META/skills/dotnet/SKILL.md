# .NET

## Purpose

This skill defines the mandatory engineering rules for .NET work in this project.

## Role in This Project

.NET is the selected managed backend application platform. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Enable and respect nullable reference types.
- Use dependency injection for application services.
- Use async APIs end-to-end for I/O operations.
- Dispose managed resources through using or framework ownership.
- Keep configuration strongly typed and validated.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not block asynchronous code with Result or Wait.
- Do not use service locator patterns.
- Do not swallow exceptions without logging or translation.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing .NET code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
