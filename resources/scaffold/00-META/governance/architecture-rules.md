# Architecture Rules

## Global Principles

- Keep responsibilities separated.
- Do not mix frontend, backend, shell and deployment concerns.
- Prefer explicit structure over hidden conventions.
- Avoid unnecessary abstraction.
- Avoid premature microservices architecture.
- Keep generated structure understandable by humans and AI agents.

## Frontend

- Frontend code belongs in the client area.
- Frontend must not contain backend runtime logic.
- UI logic must remain separated from server execution concerns.

## Server

- Server modules must remain reusable.
- Runtime composition belongs to local or remote entry points.
- Modules should not depend on whether they run locally or remotely.
- Transport-specific concerns must stay at runtime boundaries.

## Shells

- Shells wrap the client and connect it to the runtime environment.
- Shells must not contain business modules directly.
- Desktop, mobile and web shells must remain separated.

## Documentation

- Context describes the current state.
- Governance defines mandatory rules.
- Skills define specialized technology, workflow and structured-format constraints.
- Decisions store durable project decisions.
- Templates store reusable document models.
