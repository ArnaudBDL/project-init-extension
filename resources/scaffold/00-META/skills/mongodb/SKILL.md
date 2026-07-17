# MongoDB

## Purpose

This skill defines the mandatory engineering rules for MongoDB work in this project.

## Role in This Project

MongoDB is the selected document database. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Mandatory Rules

- Design documents around access patterns.
- Validate document schemas at application and database boundaries where configured.
- Create indexes for supported query patterns.
- Use transactions only when multi-document atomicity is required.
- Plan schema evolution explicitly.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not model MongoDB as a relational database by default.
- Do not create unbounded arrays in documents.
- Do not accept arbitrary query operators from clients.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing MongoDB code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.
