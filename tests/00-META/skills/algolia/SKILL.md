# Algolia

## Purpose

This skill defines the mandatory engineering rules for Algolia work in this project.

## Role in This Project

Algolia is the selected hosted search service. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use separate indices or replicas according to explicit ranking needs.
- Keep searchable attributes and ranking configuration versioned.
- Use secured or search-only client keys.
- Batch indexing operations.
- Minimize indexed attributes to product requirements.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not expose administrative API keys.
- Do not send sensitive source fields to hosted indices.
- Do not make dashboard-only configuration changes without versioned documentation.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Algolia code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
