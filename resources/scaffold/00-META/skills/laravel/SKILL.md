# Laravel

## Purpose

This skill defines the mandatory engineering rules for Laravel work in this project.

## Role in This Project

Laravel is the selected PHP application framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use service container bindings for replaceable dependencies.
- Validate requests before domain execution.
- Keep controllers thin.
- Use migrations for database changes.
- Use queues and jobs for asynchronous workloads according to project configuration.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not use facades to hide core domain dependencies.
- Do not mass-assign unvalidated input.
- Do not place complex queries in view templates.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Laravel code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
