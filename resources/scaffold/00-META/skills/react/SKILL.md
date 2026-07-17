# React

## Purpose

This skill defines the mandatory engineering rules for React work in this project.

## Role in This Project

React is the selected frontend user-interface library. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use function components and hooks for new code.
- Keep component state local unless it is genuinely shared.
- Use stable keys derived from domain identity when rendering lists.
- Keep effects focused on synchronization with external systems.
- Preserve one-way data flow and explicit component contracts.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not call hooks conditionally.
- Do not copy props into state without a synchronization requirement.
- Do not use array indexes as keys for mutable lists.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing React code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
