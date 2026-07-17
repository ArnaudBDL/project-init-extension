# Typesense

## Purpose

This skill defines the mandatory engineering rules for Typesense work in this project.

## Role in This Project

Typesense is the selected typo-tolerant search engine. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Define collection schemas explicitly.
- Keep document identifiers stable.
- Configure faceting and sorting fields deliberately.
- Batch imports and inspect partial failures.
- Use scoped search keys for client access where applicable.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not expose administrative API keys.
- Do not rely on auto-schema detection for governed production fields.
- Do not ignore failed documents in batch imports.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Typesense code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
