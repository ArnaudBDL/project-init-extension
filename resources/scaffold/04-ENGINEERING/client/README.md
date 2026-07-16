# Client

Frontend development workspace.

## Selected Stack

- {{PROJECT_FRONTEND_NAME}}

{{#PROJECT_HAS_FRONTEND_VARIANT}}
## Selected Variant

- {{PROJECT_FRONTEND_VARIANT_NAME}}
{{/PROJECT_HAS_FRONTEND_VARIANT}}

## Role

The client contains the user interface application.

It owns:

- screens
- routes
- UI state
- view components
- user interactions
- frontend integration services

## Getting Started

TODO: initialize the frontend project for {{PROJECT_FRONTEND_NAME}}.

## Install

TODO: define frontend install command.

## Run Development

TODO: define frontend development command.

## Build

TODO: define frontend build command.

## Test

TODO: define frontend test command.

## Expected Structure

TODO: define the frontend structure after initializing {{PROJECT_FRONTEND_NAME}}.

The structure must follow the selected frontend skill:

- ../../00-META/skills/{{FRONTEND_STACK}}/SKILL.md

## Rules

- Do not place backend runtime logic in the client.
- Do not hardcode production data.
- Keep UI structure explicit and maintainable.
- Keep feature code separated from shared utilities.

## Related META Files

- ../../00-META/context/stack.yml
- ../../00-META/governance/architecture-rules.md
- ../../00-META/skills/{{FRONTEND_STACK}}/SKILL.md
{{#PROJECT_HAS_FRONTEND_VARIANT}}
- ../../00-META/skills/{{FRONTEND_VARIANT}}/SKILL.md
{{/PROJECT_HAS_FRONTEND_VARIANT}}