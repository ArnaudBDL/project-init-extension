# Local Runtime

This directory contains the local runtime entry point for this project.


## Selected Backend Stack

- Go



## Selected Desktop Shell

- Tauri


## Role

The local runtime is used when the application needs a local runtime process.


It composes reusable server modules for local execution.



## Development

TODO: initialize the local runtime code.

## Run Development

TODO: define the local runtime development command.

## Build

TODO: define the local runtime build command.

## Test

TODO: define the local runtime test command.

## Relationship With Other Sections


- server/modules contains reusable runtime modules.
- server/local composes modules for local execution.



- shell/desktop may connect to this runtime when a desktop shell is enabled.


- shell/mobile may connect to this runtime when a mobile shell is enabled.


- shell/web may reference this runtime when local development requires it.


## Rules

- Keep local runtime code at the boundary.
- Keep local-specific responsibilities isolated.

- Do not duplicate business logic from modules.
- Keep local-specific adapters separated from reusable modules.


## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md

- ../../../00-META/skills/go/SKILL.md
