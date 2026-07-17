# Wails

## Purpose

This skill defines the mandatory engineering rules for Wails work in this project.

## Role in This Project

Wails is the selected Go desktop application shell. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Keep Go backend bindings explicit and narrow.
- Treat frontend-to-Go calls as trust boundaries.
- Keep platform-specific behavior behind adapters.
- Preserve application lifecycle and shutdown handling.
- Validate data crossing generated bindings.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not expose unrestricted filesystem or command execution to the frontend.
- Do not place UI state in global Go variables.
- Do not bypass generated binding contracts.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Wails code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
