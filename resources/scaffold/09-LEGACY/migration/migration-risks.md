# Migration Risks

## Status

Not analyzed.

## Purpose

Record risks specifically created or exposed by the legacy migration.

Project-wide confirmed risks must also be reflected in:

- ../../00-META/context/risks.md

## Active Risks

None.

## Closed Risks

None.

## Risk Format

### MIG-RISK-XXX - Risk Title

- Area:
- Impact:
- Likelihood:
- Trigger:
- Affected scope:
- Evidence:
- Mitigation:
- Contingency:
- Owner:
- Related debt:
- Related arbitration:
- Related task:

## Allowed Areas

- behavior
- compatibility
- architecture
- data
- dependencies
- security
- performance
- deployment
- operations
- schedule

## Allowed Impact Values

- low
- medium
- high
- critical

## Allowed Likelihood Values

- low
- medium
- high

## Rules

- Use stable MIG-RISK-XXX identifiers.
- Record only risks supported by confirmed migration context.
- Do not use this document for existing defects or technical debt.
- Do not use this document for unresolved architecture decisions.
- Reference ../../00-META/context/open-arbitrations.md when mitigation requires an unresolved choice.
- Reference migration-tasks.md when mitigation requires confirmed migration work.
- Track confirmed implementation work in ../../03-PRODUCT/kanban/TASKS.md.
- Move resolved or no-longer-applicable risks to Closed Risks.
- Do not delete closed risks.
- Synchronize project-level risks with 00-META/context/risks.md when applicable.
