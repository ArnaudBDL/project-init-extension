# Go

## Purpose

This skill defines the mandatory engineering rules for Go work in this project.

## Role in This Project

Go is the selected backend/runtime implementation language, owning runtime composition, backend modules, local and remote server execution, connectors, domain services and infrastructure adapters. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Recommended Structure

```txt
server/
├── modules/
├── local/
└── remote/
```

Modules contain reusable business/runtime logic and must not depend on whether they are executed locally or remotely. Local runtime composes modules for embedded, desktop or local-first execution. Remote runtime exposes or runs modules as networked services or cloud processes.

## Mandatory Rules

- Organize packages by domain or responsibility, keeping modules isolated.
- Keep runtime entry points thin and business logic out of transport handlers.
- Keep local and remote execution boundaries explicit.
- Avoid circular dependencies and prefer clear interfaces at module boundaries.
- Keep configuration explicit.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not put business logic directly in HTTP handlers.
- Do not duplicate business logic between local and remote runtimes.
- Do not create microservices by default or introduce unnecessary abstraction layers.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Go code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.

