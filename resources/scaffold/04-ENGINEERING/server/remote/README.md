# Remote Runtime

This directory contains the remote runtime entry point for this project.

{{#PROJECT_HAS_BACKEND_STACK}}
## Selected Backend Stack

- {{PROJECT_BACKEND_NAME}}
{{/PROJECT_HAS_BACKEND_STACK}}

## Runtime Target

- Remote Runtime: {{ENABLED_SERVER_REMOTE}}

## Role

{{#PROJECT_HAS_BACKEND_STACK}}
The remote runtime exposes or runs backend/runtime modules outside
the local application process.
{{/PROJECT_HAS_BACKEND_STACK}}
{{^PROJECT_HAS_BACKEND_STACK}}
The remote runtime provides a remotely executed server capability.
Its implementation responsibilities must be defined explicitly.
{{/PROJECT_HAS_BACKEND_STACK}}

## Development

{{#PROJECT_HAS_BACKEND_STACK}}
TODO: initialize the remote runtime code for {{PROJECT_BACKEND_NAME}}.
{{/PROJECT_HAS_BACKEND_STACK}}
{{^PROJECT_HAS_BACKEND_STACK}}
TODO: define the remote runtime implementation.
{{/PROJECT_HAS_BACKEND_STACK}}

## Run Development

TODO: define the remote runtime development command.

## Build

TODO: define the remote runtime build command.

## Test

TODO: define the remote runtime test command.

## Deployment

TODO: define deployment assumptions when the remote runtime target is implemented.

## Relationship With Other Sections

{{#PROJECT_HAS_BACKEND_STACK}}
- server/modules contains reusable backend/runtime modules.
- server/remote composes or exposes modules for remote execution.
{{/PROJECT_HAS_BACKEND_STACK}}
{{^PROJECT_HAS_BACKEND_STACK}}
- server/remote contains the remote runtime entry point.
{{/PROJECT_HAS_BACKEND_STACK}}
{{#PROJECT_HAS_WEB}}
- shell/web may orchestrate or expose this runtime.
{{/PROJECT_HAS_WEB}}
{{#ENABLED_SERVER_ASSETS}}
- server/assets handles shared asset concerns separately.
{{/ENABLED_SERVER_ASSETS}}

## Rules

- Keep remote runtime code at the execution boundary.
- Keep transport-specific concerns at the runtime boundary.
- Do not duplicate logic from server/local.
- Do not assume cloud infrastructure unless defined by the project context.
{{#PROJECT_HAS_BACKEND_STACK}}
- Remote entry points expose or run reusable modules.
- Business logic should remain inside modules.
{{/PROJECT_HAS_BACKEND_STACK}}

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md
{{#PROJECT_HAS_BACKEND_STACK}}
- ../../../00-META/skills/{{BACKEND_STACK}}/SKILL.md
{{/PROJECT_HAS_BACKEND_STACK}}