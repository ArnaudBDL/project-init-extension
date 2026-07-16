# Local Runtime

This directory contains the local runtime entry point for this project.

{{#PROJECT_HAS_BACKEND_STACK}}
## Selected Backend Stack

- {{PROJECT_BACKEND_NAME}}
{{/PROJECT_HAS_BACKEND_STACK}}

{{#PROJECT_HAS_DESKTOP}}
## Selected Desktop Shell

- {{PROJECT_DESKTOP_SHELL_NAME}}
{{/PROJECT_HAS_DESKTOP}}

## Role

The local runtime is used when the application needs a local runtime process.

{{#PROJECT_HAS_BACKEND_STACK}}
It composes reusable server modules for local execution.
{{/PROJECT_HAS_BACKEND_STACK}}
{{^PROJECT_HAS_BACKEND_STACK}}
Its implementation responsibilities must be defined explicitly.
{{/PROJECT_HAS_BACKEND_STACK}}

## Development

TODO: initialize the local runtime code.

## Run Development

TODO: define the local runtime development command.

## Build

TODO: define the local runtime build command.

## Test

TODO: define the local runtime test command.

## Relationship With Other Sections

{{#PROJECT_HAS_BACKEND_STACK}}
- server/modules contains reusable runtime modules.
- server/local composes modules for local execution.
{{/PROJECT_HAS_BACKEND_STACK}}
{{^PROJECT_HAS_BACKEND_STACK}}
- server/local contains the local runtime entry point.
{{/PROJECT_HAS_BACKEND_STACK}}
{{#PROJECT_HAS_DESKTOP}}
- shell/desktop may connect to this runtime when a desktop shell is enabled.
{{/PROJECT_HAS_DESKTOP}}
{{#PROJECT_HAS_MOBILE}}
- shell/mobile may connect to this runtime when a mobile shell is enabled.
{{/PROJECT_HAS_MOBILE}}
{{#PROJECT_HAS_WEB}}
- shell/web may reference this runtime when local development requires it.
{{/PROJECT_HAS_WEB}}

## Rules

- Keep local runtime code at the boundary.
- Keep local-specific responsibilities isolated.
{{#PROJECT_HAS_BACKEND_STACK}}
- Do not duplicate business logic from modules.
- Keep local-specific adapters separated from reusable modules.
{{/PROJECT_HAS_BACKEND_STACK}}

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md
{{#PROJECT_HAS_BACKEND_STACK}}
- ../../../00-META/skills/{{BACKEND_STACK}}/SKILL.md
{{/PROJECT_HAS_BACKEND_STACK}}