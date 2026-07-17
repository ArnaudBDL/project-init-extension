# Python

## Purpose

This skill defines the mandatory engineering rules for Python work in this project.

## Role in This Project

Python is the selected backend application runtime. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use type annotations for public functions and service boundaries.
- Follow the project formatter and linter configuration.
- Use virtual environment and locked dependency conventions.
- Keep side effects out of import-time execution.
- Use context managers for managed resources.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not use mutable default arguments.
- Do not catch Exception without handling or re-raising meaningfully.
- Do not build SQL or shell commands from untrusted strings.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Python code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
