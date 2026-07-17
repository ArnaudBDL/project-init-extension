# Rust

## Purpose

This skill defines the mandatory engineering rules for Rust work in this project.

## Role in This Project

Rust is the selected memory-safe systems and backend language. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Model ownership and lifetimes explicitly.
- Use Result and Option for recoverable conditions.
- Keep unsafe code isolated, justified and reviewed.
- Use cargo formatting, linting and test workflows.
- Preserve Send and Sync expectations across concurrency boundaries.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not use unwrap or expect in normal production paths.
- Do not add unsafe blocks without a documented invariant.
- Do not clone values merely to bypass ownership design.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Rust code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
