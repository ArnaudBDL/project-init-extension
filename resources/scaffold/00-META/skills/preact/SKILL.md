# Preact

## Purpose

This skill defines the mandatory engineering rules for Preact work in this project.

## Role in This Project

Preact is the selected lightweight frontend UI library. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Prefer Preact APIs and compatibility imports already chosen by the project.
- Keep bundles small and dependencies justified.
- Use function components and hooks consistently.
- Verify third-party React compatibility before adoption.
- Preserve explicit component and event contracts.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not assume every React package is Preact-compatible.
- Do not add React solely for one dependency.
- Do not sacrifice bundle goals with unnecessary libraries.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Preact code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
