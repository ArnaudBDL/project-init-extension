# Server

This directory contains server-side runtime or delivery material for this project.


## Selected Stack

- Go





## Selected Data Services


- Databases: PostgreSQL, SQLite


- Search Engines: Elasticsearch


Selected data services describe the project-level technical profile.

Their presence does not imply that every local or remote runtime consumes every
selected data service.



## Runtime Targets

- Local Runtime: true
- Remote Runtime: true
- Asset Server: true


## Role

The server area contains the runtime and delivery sections generated from the
CLI interview answers.

## Generated Structure

- modules: reusable backend/runtime modules
- local: local runtime entry point
- remote: remote runtime entry point
- assets: shared asset delivery

## Development


TODO: initialize backend/runtime code for Go.

## Install

TODO: define backend install command.

## Run Development

TODO: define backend development command.

## Build

TODO: define backend build command.

## Test

TODO: define backend test command.



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
