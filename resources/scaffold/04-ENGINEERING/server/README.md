# Server

This directory contains server-side runtime or delivery material for this project.

{{#PROJECT_HAS_BACKEND_STACK}}
## Selected Stack

- {{PROJECT_BACKEND_NAME}}
{{/PROJECT_HAS_BACKEND_STACK}}

{{#PROJECT_HAS_BACKEND_FRAMEWORK}}
## Selected Framework

- {{PROJECT_BACKEND_FRAMEWORK_NAME}}
{{/PROJECT_HAS_BACKEND_FRAMEWORK}}

{{#PROJECT_HAS_DATA_SERVICES}}
## Selected Data Services

{{#PROJECT_HAS_DATABASES}}
- Databases: {{PROJECT_DATABASE_NAMES}}
{{/PROJECT_HAS_DATABASES}}
{{#PROJECT_HAS_SEARCH_ENGINES}}
- Search Engines: {{PROJECT_SEARCH_ENGINE_NAMES}}
{{/PROJECT_HAS_SEARCH_ENGINES}}

Selected data services describe the project-level technical profile.

Their presence does not imply that every local or remote runtime consumes every
selected data service.
{{/PROJECT_HAS_DATA_SERVICES}}

{{#PROJECT_HAS_RUNTIME_TARGETS}}
## Runtime Targets

{{ENGINEERING_RUNTIME_TARGETS}}
{{/PROJECT_HAS_RUNTIME_TARGETS}}

## Role

The server area contains the runtime and delivery sections generated from the
CLI interview answers.

## Generated Structure

{{SERVER_GENERATED_STRUCTURE}}

## Development

{{#PROJECT_HAS_BACKEND_STACK}}
TODO: initialize backend/runtime code for {{PROJECT_BACKEND_NAME}}.

## Install

TODO: define backend install command.

## Run Development

TODO: define backend development command.

## Build

TODO: define backend build command.

## Test

TODO: define backend test command.
{{/PROJECT_HAS_BACKEND_STACK}}
{{^PROJECT_HAS_BACKEND_STACK}}
TODO: define the development workflow for the generated server delivery sections.
{{/PROJECT_HAS_BACKEND_STACK}}

## Rules

- Runtime composition belongs to local or remote entry points.
- Business modules must remain reusable.
- Modules should not depend on whether they run locally or remotely.
- Transport-specific concerns must stay at runtime boundaries.
- The asset server may exist independently from local and remote runtimes.
- The asset server does not require a backend stack.
- Keep shared asset delivery separate from runtime execution.
- Keep this server documentation aligned with the generated server structure.

## Related META Files

- ../../00-META/context/stack.yml
- ../../00-META/governance/architecture-rules.md
- ../../00-META/governance/naming-rules.md
- ../../00-META/skills/README.md