# Backoffice

This directory contains the management and administration client application
for this project.

## Application Identity

- Name: {{PROJECT_SLUG}}-backoffice
- Role: Backoffice

## Selected Frontend Stack

- {{PROJECT_FRONTEND_NAME}}

{{#PROJECT_HAS_FRONTEND_VARIANT}}
## Selected Frontend Variant

- {{PROJECT_FRONTEND_VARIANT_NAME}}
{{/PROJECT_HAS_FRONTEND_VARIANT}}

## Role

The backoffice contains the interfaces used to manage, configure, administer
and supervise the project.

It may own:

- management screens
- administration workflows
- configuration interfaces
- operational dashboards
- supervision interfaces
- restricted user interactions

## Getting Started

TODO: initialize the backoffice project for {{PROJECT_FRONTEND_NAME}}.

## Install

TODO: define the backoffice install command.

## Run Development

TODO: define the backoffice development command.

## Build

TODO: define the backoffice build command.

## Test

TODO: define the backoffice test command.

## Rules

- Do not place backend runtime logic in the backoffice.
- Keep management and administration responsibilities explicit.
- Do not duplicate frontoffice behavior without an explicit reason.
- Keep access restrictions and privileged operations documented.
- Do not assume that every backoffice user is a system administrator.

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/context/architecture.md
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md
- ../../../00-META/skills/{{FRONTEND_STACK}}/SKILL.md
{{#PROJECT_HAS_FRONTEND_VARIANT}}
- ../../../00-META/skills/{{FRONTEND_VARIANT}}/SKILL.md
{{/PROJECT_HAS_FRONTEND_VARIANT}}