# Ruby on Rails

## Purpose

This skill defines the mandatory engineering rules for Ruby on Rails work in this project.

## Role in This Project

Ruby on Rails is the selected Ruby web application framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Follow Rails conventions unless the project documents an exception.
- Keep controllers thin.
- Use migrations for schema changes.
- Prevent N+1 queries with explicit loading.
- Use strong parameters and explicit authorization.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not place business workflows in callbacks by default.
- Do not bypass strong parameters.
- Do not execute database queries from views.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Ruby on Rails code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
