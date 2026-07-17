# Ruby

## Purpose

This skill defines the mandatory engineering rules for Ruby work in this project.

## Role in This Project

Ruby is the selected dynamic backend application language. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Follow the project Ruby and style-tool versions.
- Keep objects focused and public interfaces small.
- Use keyword arguments for complex service boundaries.
- Handle nil and failure paths explicitly.
- Keep metaprogramming limited and documented.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not monkey-patch global classes without an explicit project decision.
- Do not rescue Exception.
- Do not hide database queries inside presentation code.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Ruby code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
