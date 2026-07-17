# Architecture

This document describes the generated technical architecture for the project.

It is based on the CLI interview answers and must stay aligned with stack.yml and 04-ENGINEERING.

## Generated Technical Profile


- Frontend: Angular



- Backend: Go



- Databases: PostgreSQL, SQLite


- Search Engines: Elasticsearch, OpenSearch, Algolia


- Local Runtime: enabled


- Remote Runtime: enabled


- Asset Server: enabled


- Desktop Shell: Tauri


- Mobile Shell: Capacitor


- Web Shell: Docker Web Runtime


## Layers


- client: user interface application.


- server: runtime, backend or delivery material.


- server/modules: reusable backend/runtime modules.


- server/local: local runtime entry point.


- server/remote: remote runtime entry point.


- server/assets: shared asset delivery.


- shell: platform shell layer.


- shell/desktop: desktop shell implementation.


- shell/mobile: mobile shell implementation.


- shell/web: web exposure and runtime integration of the frontend client.


## Data Architecture

### Databases And Data Stores

- PostgreSQL
- SQLite

### Search Engines

- Elasticsearch
- OpenSearch
- Algolia

## Architecture Rules

- Keep frontend, server, shell and delivery concerns separated.
- Runtime composition belongs to local or remote entry points.
- Reusable backend/runtime logic belongs in server/modules when a backend stack is selected.
- Shells expose or integrate the client with the selected target environment.
- Runtime concerns and asset delivery concerns must remain separated.
- The asset server is an autonomous server capability.
- Asset delivery does not require a local runtime, remote runtime or backend stack.
- The asset server technology must remain undefined until explicitly selected.
- Shared asset delivery must remain separated from frontend assets, backend runtime logic and web shell responsibilities.
- A frontend variant must not implicitly select or replace the backend stack.
- Server-side capabilities required by a frontend variant remain part of the client or web shell integration unless explicitly modeled as backend runtime responsibilities.
- Databases and search engines are independent infrastructure capabilities.
- Selecting a database must not implicitly select a backend stack or framework.
- Selecting a search engine must not implicitly select a database.
- A search engine must not silently become the primary source of truth.
- Data ownership, synchronization and indexing boundaries must be documented when relevant.
- Multiple selected data services must have explicit responsibilities before implementation.

## Delivery

### CI/CD

Not defined.

### Hosting

Not defined.

### Observability

Not defined.

Delivery values must remain undefined until they are explicitly confirmed.

Do not infer a CI/CD platform, hosting provider or observability stack from the selected application stack.

## Notes

This document is a human-readable architecture summary.

The machine-readable technical source of truth is:

- stack.yml

Detailed implementation constraints belong in:

- 00-META/governance
- 00-META/skills
