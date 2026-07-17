# Business Rules

## Status

Not analyzed.

## Purpose

Document business behavior that must be understood before migration.

Business rules must be supported by implementation code, tests, configuration,
existing documentation or explicit user confirmation.

## Rule Format

### BR-XXX - Rule Title

- Status: confirmed | unclear | obsolete
- Scope:
- Trigger:
- Preconditions:
- Rule:
- Result:
- Exceptions:
- Side effects:
- Evidence:
- Related components:
- Migration requirement:

## Confirmed Rules

None.

## Unclear Rules

None.

## Potentially Obsolete Rules

None.

## Validation Gaps

Identify rules that are implemented but not covered by tests or reliable
documentation.

None.

## Cross-Rule Dependencies

Document dependencies or ordering constraints between confirmed rules.

None.

## Rules

- Use stable BR-XXX identifiers.
- Do not create a business rule from a technical implementation detail alone.
- Do not infer intent from behavior when intent is not documented.
- Keep unclear behavior in the Unclear Rules section.
- Do not remove potentially obsolete behavior without explicit validation.
- Reference tests when tests provide the strongest evidence.
- Link implementation tasks only after the migration requirement is confirmed.
