# Source Tree

## Status

Not analyzed.

## Source Location

The legacy source code is stored in:

- 09-LEGACY/codebase/

## Tree Overview

Record the relevant source tree without including generated dependencies, build
outputs, caches or unrelated binary material.

TODO

## Directory Responsibilities

For each significant directory, document its confirmed responsibility.

### Directory

- Path:
- Responsibility:
- Main entry points:
- Dependencies:
- Consumers:
- Migration relevance:
- Evidence:

## Important Files

Document files that define application startup, dependency management,
configuration, build, deployment, data schema or runtime behavior.

### File

- Path:
- Purpose:
- Used by:
- Migration relevance:
- Evidence:

## Generated And Vendor Content

Identify directories that contain generated code, vendored dependencies, build
outputs or external artifacts.

TODO

## Unclear Areas

Identify directories or files whose responsibility remains unresolved.

TODO

## Migration Boundaries

Record confirmed boundaries that can be migrated, isolated, replaced or removed
independently.

TODO

## Rules

- Preserve original paths in every reference.
- Do not document generated dependencies as application modules.
- Do not assign responsibilities based only on directory names.
- Reference concrete files when describing a directory responsibility.
- Keep target structure proposals in migration-plan.md.
