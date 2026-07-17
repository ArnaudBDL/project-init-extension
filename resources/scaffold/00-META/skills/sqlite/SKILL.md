# SQLite

## Purpose

This skill defines the mandatory engineering rules for SQLite work in this project.

## Role in This Project

SQLite is the selected embedded relational database. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Enable and verify foreign-key enforcement for each connection.
- Use versioned migrations.
- Keep write transactions short.
- Use parameterized queries.
- Choose journal and locking configuration deliberately for the application.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not assume server-database concurrency characteristics.
- Do not concatenate untrusted values into SQL.
- Do not store the database in an unsafe ephemeral path without an explicit decision.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing SQLite code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
