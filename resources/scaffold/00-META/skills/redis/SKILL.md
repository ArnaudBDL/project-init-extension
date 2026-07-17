# Redis

## Purpose

This skill defines the mandatory engineering rules for Redis work in this project.

## Role in This Project

Redis is the selected in-memory data store. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Define key namespaces and ownership.
- Set expiration for cache entries where appropriate.
- Treat Redis as non-authoritative unless explicitly designed otherwise.
- Use atomic operations or scripts for multi-step invariants.
- Plan memory limits and eviction behavior.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not store secrets in readable keys.
- Do not use KEYS in production paths.
- Do not assume cached data is always present or durable.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Redis code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
