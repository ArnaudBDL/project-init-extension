# HTML/CSS/JS

## Purpose

This skill defines the mandatory engineering rules for static HTML/CSS/JS work in this project.

## Role in This Project

HTML/CSS/JS is the selected static frontend implementation, used for static pages, prototypes, lightweight interfaces, documentation-driven frontends and non-framework UI experiments. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Important Distinction

Static JSON is not a frontend stack. It is a content or data mode. If static JSON becomes necessary later, it should be modeled separately from `FRONTEND_STACK`.

## Mandatory Rules

- Keep HTML structure explicit and CSS readable and organized.
- Keep JavaScript behavior separated from markup when possible.
- Avoid unnecessary framework-like abstractions and hidden state management.
- Keep assets and data references clear.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not simulate a framework architecture unless explicitly required.
- Do not mix temporary prototype logic with durable implementation code.
- Do not hardcode production data as final content.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing HTML/CSS/JS code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.

