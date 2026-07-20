# {{SERVICE_DISPLAY_NAME}} Service

This directory contains the {{SERVICE_DISPLAY_NAME}} remote service for this project.

## Service Identity

- Name: {{SERVICE_NAME}}
- Domain: {{SERVICE_DOMAIN}}

## Selected Backend Stack

- {{PROJECT_BACKEND_NAME}}

{{#PROJECT_HAS_BACKEND_FRAMEWORK}}
## Selected Backend Framework

- {{PROJECT_BACKEND_FRAMEWORK_NAME}}
{{/PROJECT_HAS_BACKEND_FRAMEWORK}}

## Role

This service owns the remote server responsibilities assigned to the
{{SERVICE_DISPLAY_NAME}} domain.

## Development

TODO: initialize the {{SERVICE_DISPLAY_NAME}} service.

## Run Development

TODO: define the service development command.

## Build

TODO: define the service build command.

## Test

TODO: define the service test command.

## Deployment

TODO: define the service deployment assumptions.

## Rules

- Keep the service boundary explicit.
- Do not duplicate responsibilities owned by another service.
- Keep domain logic independent from transport-specific concerns.
- Keep configuration explicit.
- Keep sensitive configuration externalized.
- Document inter-service dependencies before implementation.

## Related META Files

- ../../../../00-META/context/stack.yml
- ../../../../00-META/context/architecture.md
- ../../../../00-META/governance/architecture-rules.md
- ../../../../00-META/governance/security-rules.md
- ../../../../00-META/skills/{{BACKEND_STACK}}/SKILL.md