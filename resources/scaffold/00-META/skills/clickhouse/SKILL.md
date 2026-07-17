# ClickHouse

## Purpose

This skill defines the mandatory engineering rules for ClickHouse work in this project.

## Role in This Project

ClickHouse is the selected column-oriented analytical database. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Design tables and ordering keys for analytical query patterns.
- Batch inserts.
- Use partitions for lifecycle management rather than arbitrary sharding.
- Treat mutations as exceptional operations.
- Validate aggregation semantics and time zones.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not use ClickHouse as a transactional row store.
- Do not issue frequent single-row updates or deletes.
- Do not select unnecessary columns from wide tables.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing ClickHouse code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
