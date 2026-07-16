# Architecture

This document describes the generated technical architecture for the project.

It is based on the CLI interview answers and must stay aligned with stack.yml and 04-ENGINEERING.

## Generated Technical Profile

{{#PROJECT_HAS_FRONTEND}}
- Frontend: {{PROJECT_FRONTEND_NAME}}
{{/PROJECT_HAS_FRONTEND}}
{{#PROJECT_HAS_FRONTEND_VARIANT}}
- Frontend Variant: {{PROJECT_FRONTEND_VARIANT_NAME}}
{{/PROJECT_HAS_FRONTEND_VARIANT}}
{{#PROJECT_HAS_BACKEND_STACK}}
- Backend: {{PROJECT_BACKEND_NAME}}
{{/PROJECT_HAS_BACKEND_STACK}}
{{#PROJECT_HAS_BACKEND_FRAMEWORK}}
- Backend Framework: {{PROJECT_BACKEND_FRAMEWORK_NAME}}
{{/PROJECT_HAS_BACKEND_FRAMEWORK}}
{{#PROJECT_HAS_DATABASES}}
- Databases: {{PROJECT_DATABASE_NAMES}}
{{/PROJECT_HAS_DATABASES}}
{{#PROJECT_HAS_SEARCH_ENGINES}}
- Search Engines: {{PROJECT_SEARCH_ENGINE_NAMES}}
{{/PROJECT_HAS_SEARCH_ENGINES}}
{{#ENABLED_SERVER_LOCAL}}
- Local Runtime: enabled
{{/ENABLED_SERVER_LOCAL}}
{{#ENABLED_SERVER_REMOTE}}
- Remote Runtime: enabled
{{/ENABLED_SERVER_REMOTE}}
{{#ENABLED_SERVER_ASSETS}}
- Asset Server: enabled
{{/ENABLED_SERVER_ASSETS}}
{{#PROJECT_HAS_DESKTOP}}
- Desktop Shell: {{PROJECT_DESKTOP_SHELL_NAME}}
{{/PROJECT_HAS_DESKTOP}}
{{#PROJECT_HAS_MOBILE}}
- Mobile Shell: {{PROJECT_MOBILE_SHELL_NAME}}
{{/PROJECT_HAS_MOBILE}}
{{#PROJECT_HAS_WEB}}
- Web Shell: {{PROJECT_WEB_SHELL_NAME}}
{{/PROJECT_HAS_WEB}}

## Layers

{{#PROJECT_HAS_FRONTEND}}
- client: user interface application.
{{/PROJECT_HAS_FRONTEND}}
{{#PROJECT_HAS_SERVER}}
- server: runtime, backend or delivery material.
{{/PROJECT_HAS_SERVER}}
{{#PROJECT_HAS_BACKEND_STACK}}
- server/modules: reusable backend/runtime modules.
{{/PROJECT_HAS_BACKEND_STACK}}
{{#ENABLED_SERVER_LOCAL}}
- server/local: local runtime entry point.
{{/ENABLED_SERVER_LOCAL}}
{{#ENABLED_SERVER_REMOTE}}
- server/remote: remote runtime entry point.
{{/ENABLED_SERVER_REMOTE}}
{{#ENABLED_SERVER_ASSETS}}
- server/assets: shared asset delivery.
{{/ENABLED_SERVER_ASSETS}}
{{#PROJECT_HAS_SHELL}}
- shell: platform shell layer.
{{/PROJECT_HAS_SHELL}}
{{#PROJECT_HAS_DESKTOP}}
- shell/desktop: desktop shell implementation.
{{/PROJECT_HAS_DESKTOP}}
{{#PROJECT_HAS_MOBILE}}
- shell/mobile: mobile shell implementation.
{{/PROJECT_HAS_MOBILE}}
{{#PROJECT_HAS_WEB}}
- shell/web: web exposure and runtime integration of the frontend client.
{{/PROJECT_HAS_WEB}}

## Data Architecture

### Databases And Data Stores

{{DATABASE_BULLETS}}

### Search Engines

{{SEARCH_ENGINE_BULLETS}}

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