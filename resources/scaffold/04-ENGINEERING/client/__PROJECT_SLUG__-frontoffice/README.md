# Frontoffice

This directory contains the primary user-facing client application for this project.

## Application Identity

- Name: {{PROJECT_SLUG}}-frontoffice
- Role: Frontoffice

## Selected Frontend Stack

- {{PROJECT_FRONTEND_NAME}}

{{#PROJECT_HAS_FRONTEND_VARIANT}}
## Selected Frontend Variant

- {{PROJECT_FRONTEND_VARIANT_NAME}}
{{/PROJECT_HAS_FRONTEND_VARIANT}}

## Role

The frontoffice contains the primary application experience intended for the
project users.

It owns:

- user-facing screens
- routes
- UI state
- view components
- user interactions
- frontend integration services

## Getting Started

TODO: initialize the frontoffice project for {{PROJECT_FRONTEND_NAME}}.

## Install

TODO: define the frontoffice install command.

## Run Development

TODO: define the frontoffice development command.

## Build

TODO: define the frontoffice build command.

## Test

TODO: define the frontoffice test command.

## Rules

- Do not place backend runtime logic in the frontoffice.
- Do not hardcode production data.
- Keep UI structure explicit and maintainable.
- Keep feature code separated from shared utilities.
- Do not place backoffice-specific behavior in the frontoffice.

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/context/architecture.md
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/skills/{{FRONTEND_STACK}}/SKILL.md
{{#PROJECT_HAS_FRONTEND_VARIANT}}
- ../../../00-META/skills/{{FRONTEND_VARIANT}}/SKILL.md
{{/PROJECT_HAS_FRONTEND_VARIANT}}