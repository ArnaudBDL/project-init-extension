# Review Playbook

## Purpose

This playbook defines how humans and AI agents must review generated or
modified project work.

A review validates a defined scope against the project source of truth.

A review must not become an unrelated redesign, migration or refactoring task.

## Required Reading

Before reviewing, read:

- 00-META/context/README.md
- 00-META/context/open-arbitrations.md
- 00-META/context/risks.md
- 00-META/context/identity.md
- 00-META/context/vision.md
- 00-META/context/stack.yml
- 00-META/context/architecture.md
- 00-META/context/framing.md
- 00-META/governance/README.md
- 00-META/governance/architecture-rules.md
- 00-META/governance/naming-rules.md
- 00-META/governance/security-rules.md
- 00-META/decisions/
- 00-META/skills/README.md

Read the relevant technology, Kanban and specification skills according to the
reviewed scope.

## Review Scope

When the task identifies files, directories or changes:

- review the identified scope
- review directly affected project documents
- do not expand the review without a concrete dependency

When no scope is identified:

- perform a project-wide consistency review
- state explicitly that the review is project-wide

## Workflow

1. Define the exact review scope.
2. Read the applicable context, governance, decisions and skills.
3. Identify the expected structure or behavior.
4. Compare the reviewed work with the applicable project rules.
5. Record factual findings with precise locations.
6. Classify each finding by severity.
7. Separate deterministic corrections from required arbitrations.
8. Apply corrections only when explicitly requested.
9. Re-check modified files after correction.
10. Provide one focused commit command when changes were made.

## Review Checklist

Verify:

- context consistency
- stack and engineering alignment
- architecture boundary compliance
- governance compliance
- relevant skill compliance
- accepted decision compliance
- open arbitration handling
- absence of reintroduced dropped arbitrations
- absence of invented project facts
- absence of unsupported requirements
- specification consistency
- Kanban consistency
- file reference validity
- naming consistency
- documentation alignment
- duplicated information
- obsolete references
- changes outside the requested scope
- risk register consistency
- risk mitigation alignment
- consistency between risks, arbitrations and Kanban tasks

## Finding Severity

Use only:

### BLOCKING

The issue prevents correct execution, generation or project use.

Examples:

- invalid generated syntax
- missing mandatory file
- reference to a required file that cannot exist
- project structure incompatible with an accepted convention

### MAJOR

The issue creates a contradiction, invalid structure or significant project
risk without necessarily preventing immediate execution.

Examples:

- contradiction between context and implementation
- violation of an accepted architecture decision
- open arbitration treated as a confirmed fact
- dropped arbitration reintroduced
- unsupported Kanban or specification structure

### MINOR

The issue creates limited inconsistency, ambiguity or maintainability cost.

Examples:

- obsolete wording
- incomplete directory documentation
- inconsistent terminology without functional impact

Do not assign severity without describing the concrete impact.

## Finding Format

Each finding must contain:

Severity:
Location:
Finding:
Evidence:
Required Correction:

Location must identify the exact file and, when possible, the function, section
or symbol.

## Deterministic Corrections

A correction is deterministic when it is directly required by:

- a confirmed context document
- an accepted decision
- a mandatory governance rule
- an applicable skill
- an established project convention

Deterministic corrections may be applied only when the user explicitly requests
modifications.

## Required Arbitrations

User arbitration is required when:

- multiple valid solutions exist
- project context is incomplete
- an open arbitration covers the subject
- the proposed correction changes project scope
- the proposed correction changes architecture
- the proposed correction invalidates an accepted decision

Do not silently resolve these cases.

Add unresolved decisions to open-arbitrations.md only when explicitly requested.

## Modification Rules

When correcting reviewed work:

- modify only confirmed defects
- preserve validated decisions
- preserve unrelated working code
- avoid broad rewrites
- avoid unsolicited improvements
- list every modified file
- re-check each modified area
- leave unresolved arbitrations unchanged

## Specifications

Verify that specifications:

- follow 00-META/skills/specs/SKILL.md
- use confirmed requirements
- contain the required sections
- use supported status values
- use stable requirement identifiers
- do not silently resolve open questions
- do not duplicate existing specification scope

## Kanban

Verify that the Kanban:

- follows 00-META/skills/kanban/SKILL.md
- uses only supported columns
- uses only supported properties
- uses unique task identifiers
- references existing detail files
- does not create tasks from open arbitrations
- does not replace project specifications

## Risks

Verify that risks:

- use unique and stable RISK-XXX identifiers
- use supported area, impact and likelihood values
- are grounded in confirmed project context
- are not duplicated as open arbitrations
- are not used directly as implementation tasks
- reference Kanban work when mitigation requires implementation
- reference an open arbitration when mitigation requires an unresolved choice
- remain preserved after being moved to Closed

## Expected Output

A review must provide:

- reviewed scope
- validated elements
- factual findings grouped by severity
- required arbitrations
- deterministic corrections
- affected files
- recommended commit command when changes were made

Omit empty finding groups.

Never claim that unreviewed areas are valid.

## Commit Format

git add . && git commit -m "review project consistency"
