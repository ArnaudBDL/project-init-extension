# Angular

## Purpose

This skill defines the mandatory engineering rules for Angular work in this project.

## Role in This Project

Angular is the selected frontend application framework, owning screens, routes, UI state, components, frontend services and user interactions. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Recommended Structure

```txt
client/
└── src/
		└── app/
				├── core/
				├── shared/
				├── features/
				├── layouts/
				└── routes/
```

## Mandatory Rules

- Prefer standalone components.
- Use feature-first organization.
- Keep UI components focused on presentation and interaction.
- Keep business/runtime logic outside components.
- Keep routing readable and predictable.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not place backend runtime logic in Angular.
- Do not generate fake services as final implementation.
- Do not change visual structure unless explicitly requested.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Angular code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.

