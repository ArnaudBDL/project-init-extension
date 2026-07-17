# Migration Tasks

## Purpose

Track migration-specific work derived from the confirmed migration plan.

This document identifies migration work and its relationship with source code,
target code, migration risks and project Kanban tasks.

It does not replace the project Kanban.

Confirmed implementation work must be tracked in:

- ../../03-PRODUCT/kanban/TASKS.md

## Migration Work

None.

## Task Format

### MIG-XXX - Task Title

- phase:
- scope:
- sourcePaths:
- targetPaths:
- dependencies:
- blockers:
- preservedBehavior:
- expectedResult:
- validation:
- rollback:
- relatedRisks:
- relatedDebts:
- relatedDecision:
- kanbanTask:

## Rules

- Use stable MIG-XXX identifiers.
- Create migration work only from confirmed migration scope.
- One entry must represent one reviewable migration deliverable.
- Do not create implementation work from unresolved arbitrations.
- Do not use this document as a substitute for specifications.
- Every implementation entry must reference its project Kanban task.
- Track execution status only in ../../03-PRODUCT/kanban/TASKS.md.
- Keep dependencies, blockers and validation criteria explicit.
- Preserve completed migration entries for traceability.
