# Server Modules

This directory contains reusable backendThis directory contains reusable backend/runtime modules for this project.
## Selected Backend Stack

- Go

## Role

Server modules contain reusable business, domain or runtime logic.

They are designed to be composed by runtime entry points.

## Development

TODO: initialize module structure for Go.

## Build

TODO: define module build command if modules are built independently.

## Test

TODO: define module test command.

## Expected Module Responsibilities

Modules may contain:

- domain services
- business logic
- connectors
- import/export logic
- validation logic
- infrastructure adapters when scoped to the module

## Relationship With Runtime Targets

- server/local composes modules for local execution when enabled.
- server/remote exposes or runs modules for remote execution when enabled.
- modules must not depend on whether they are executed locally or remotely.

## Rules

- Keep modules isolated.
- Avoid circular dependencies.
- Do not bind modules directly to a transport layer.
- Do not place runtime composition inside modules.
- Do not duplicate logic between local and remote runtimes.
- Do not document modules that are not part of this project.

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/naming-rules.md
- ../../../00-META/skills/go/SKILL.md
