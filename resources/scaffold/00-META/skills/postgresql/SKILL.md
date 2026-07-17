# PostgreSQL

## Purpose

This skill defines the mandatory engineering rules for PostgreSQL work in this project.

## Role in This Project

PostgreSQL is the selected relational database. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use versioned migrations for schema changes.
- Define constraints in the database for durable invariants.
- Use parameterized queries.
- Review indexes against actual query patterns.
- Use explicit transaction boundaries.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not use SELECT * in stable application queries.
- Do not add indexes without considering write cost.
- Do not concatenate untrusted values into SQL.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing PostgreSQL code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
