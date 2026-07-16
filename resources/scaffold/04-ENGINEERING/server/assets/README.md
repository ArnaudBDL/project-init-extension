
# Asset Server

This directory contains shared asset delivery material for this project.

## Asset Server Support

- Enabled: {{ENABLED_SERVER_ASSETS}}

## Role

The asset server is an autonomous server capability.

It can exist without:

- a local runtime
- a remote runtime
- a backend application stack
- reusable backend modules

Its implementation technology must remain undefined until explicitly selected.

## Responsibilities

The asset server may own:

- shared static asset distribution
- public asset delivery
- shared media delivery
- asset storage strategy
- asset synchronization strategy
- asset publication workflow
- asset validation
- cache and delivery configuration when required

## Development

TODO: define the shared asset delivery implementation.

## Build / Publish

TODO: define shared asset build, publishing or synchronization commands.

## Architecture Boundaries

Frontend build assets belong in:

```txt
client/
```

Shared asset delivery belongs in:

```txt
server/assets/
```

Web exposure of the frontend client belongs in:

```txt
shell/web/
```

Backend runtime execution belongs in:

```txt
server/local/
server/remote/
```

The asset server must not duplicate frontend, runtime or shell
responsibilities.

## Relationship With Other Sections

{{#PROJECT_HAS_FRONTEND}}
client may consume shared assets but does not own their shared delivery. {{/PROJECT_HAS_FRONTEND}} {{#ENABLED_SERVER_LOCAL}}
server/local remains independent from shared asset delivery. {{/ENABLED_SERVER_LOCAL}} {{#ENABLED_SERVER_REMOTE}}
server/remote remains independent from shared asset delivery. {{/ENABLED_SERVER_REMOTE}} {{#PROJECT_HAS_WEB}}
shell/web may consume shared assets but does not own their delivery. {{/PROJECT_HAS_WEB}}
server/assets owns shared asset delivery concerns.

## Rules

- Do not place application business logic in server/assets.
- Do not place frontend application source code in server/assets.
- Do not duplicate local or remote runtime logic.
- Do not move web shell responsibilities into server/assets.
- Do not hardcode production asset endpoints.
- Do not assume an implementation technology without an explicit decision.
- Keep publishing, synchronization and delivery assumptions documented.
- Keep sensitive configuration externalized.

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/context/architecture.md
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md