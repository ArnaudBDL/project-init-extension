# Remote Runtime

This directory contains the remote runtime entry point for this project.


## Selected Backend Stack

- Go


## Runtime Target

- Remote Runtime: true

## Role


The remote runtime exposes or runs backend/runtime modules outside
the local application process.



## Development


TODO: initialize the remote runtime code for Go.



## Run Development

TODO: define the remote runtime development command.

## Build

TODO: define the remote runtime build command.

## Test

TODO: define the remote runtime test command.

## Deployment

TODO: define deployment assumptions when the remote runtime target is implemented.

## Relationship With Other Sections


- server/modules contains reusable backend/runtime modules.
- server/remote composes or exposes modules for remote execution.



- shell/web may orchestrate or expose this runtime.


- server/assets handles shared asset concerns separately.


## Rules

- Keep remote runtime code at the execution boundary.
- Keep transport-specific concerns at the runtime boundary.
- Do not duplicate logic from server/local.
- Do not assume cloud infrastructure unless defined by the project context.

- Remote entry points expose or run reusable modules.
- Business logic should remain inside modules.


## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md

- ../../../00-META/skills/go/SKILL.md
