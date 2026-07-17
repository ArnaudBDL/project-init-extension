# Vue

## Purpose

This skill defines the mandatory engineering rules for Vue work in this project.

## Role in This Project

Vue is the selected progressive frontend framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use the Composition API for new components.
- Keep reactive state explicit with ref, reactive and computed.
- Use props and emits as explicit component contracts.
- Keep composables focused and independently testable.
- Preserve Vue single-file component boundaries.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not mutate props.
- Do not hide side effects inside computed values.
- Do not mix Options API and Composition API without an existing project convention.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Vue code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
