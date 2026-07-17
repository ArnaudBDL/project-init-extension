# Next.js

## Purpose

This skill defines the mandatory engineering rules for Next.js work in this project.

## Role in This Project

Next.js is the selected React application framework. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Use the project-selected router consistently.
- Keep server and client component boundaries explicit.
- Add client directives only where browser interactivity is required.
- Use framework data and cache primitives deliberately.
- Keep route handlers thin and delegate domain logic.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not expose server secrets to client components.
- Do not mix router conventions in the same application.
- Do not mark whole subtrees as client components without need.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Next.js code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
