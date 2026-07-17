# Migration Plan

## Status

Draft.

## Objective

Define the confirmed path from the analyzed legacy state to the target
architecture.

TODO

## Source State

Summarize the confirmed legacy state using the analysis documents in this
directory.

TODO

## Target State

Reference the confirmed target architecture documented in:

- ../../00-META/context/stack.yml
- ../../00-META/context/architecture.md
- ../../00-META/decisions/

TODO

## Migration Scope

Identify the components, behavior, data, integrations and operational concerns
included in this migration.

TODO

## Out Of Scope

Identify elements explicitly excluded from this migration.

TODO

## Preserved Behavior

List behavior and compatibility obligations that must remain stable.

TODO

## Intended Changes

List confirmed behavior, architecture, technology or operational changes.

TODO

## Migration Strategy

Describe the confirmed migration strategy.

TODO

## Phases

### Phase 1 - Analysis Completion

- Scope:
- Preconditions:
- Deliverables:
- Validation:
- Exit criteria:

### Phase 2 - Target Foundation

- Scope:
- Preconditions:
- Deliverables:
- Validation:
- Exit criteria:

### Phase 3 - Incremental Migration

- Scope:
- Preconditions:
- Deliverables:
- Validation:
- Exit criteria:

### Phase 4 - Cutover

- Scope:
- Preconditions:
- Deliverables:
- Validation:
- Exit criteria:

### Phase 5 - Legacy Retirement

- Scope:
- Preconditions:
- Deliverables:
- Validation:
- Exit criteria:

## Data Migration

Define data ownership, transformation, synchronization, validation, cutover and
rollback when applicable.

TODO

## Integration Migration

Define how external integrations will be preserved, adapted, replaced or removed.

TODO

## Compatibility Strategy

Define confirmed compatibility requirements and transition boundaries.

TODO

## Validation Strategy

Define how preserved behavior, migrated data, integrations, security,
performance and operations will be validated.

TODO

## Rollback Strategy

Define rollback conditions, preserved artifacts and recovery steps when a
rollback is required.

TODO

## Cutover Criteria

TODO

## Completion Criteria

TODO

## Dependencies

TODO

## Blocking Decisions

None.

## Related Risks

None.

## Related Tasks

See migration-tasks.md.

## Rules

- Do not define target architecture independently from 00-META.
- Do not create migration phases from unconfirmed assumptions.
- Do not combine unrelated feature development with migration work.
- Preserve confirmed business behavior unless an explicit decision changes it.
- Resolve blocking decisions before creating executable migration tasks.
- Keep each phase reviewable and reversible when required.
