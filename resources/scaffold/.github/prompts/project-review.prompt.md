---
description: "Review project consistency without expanding the requested scope"
---

## Required Reading

Read first:

- ../../00-META/context/README.md
- ../../00-META/context/open-arbitrations.md
- ../../00-META/context/risks.md
- ../../00-META/context/identity.md
- ../../00-META/context/vision.md
- ../../00-META/context/stack.yml
- ../../00-META/context/architecture.md
- ../../00-META/context/framing.md
- ../../00-META/governance/README.md
- ../../00-META/governance/architecture-rules.md
- ../../00-META/governance/naming-rules.md
- ../../00-META/governance/security-rules.md
- ../../00-META/decisions/
- ../../00-META/skills/README.md
- ../../00-META/playbooks/review.md

Read relevant technology, Kanban and specification skills according to the review scope.

## Goal

Review the requested project scope for consistency, correctness and compliance with the documented project source of truth.

A review identifies problems.

A review must not become an unrelated redesign, migration or refactoring task.

## Review Scope

If the user identifies files, directories or changes, review only that scope
and the directly affected project documents.

If no explicit scope is provided, perform a project-wide consistency review.

Do not expand the review scope without a concrete dependency or documented inconsistency.

## Sources Of Truth

Use:

- context for current project facts
- open-arbitrations.md for unresolved, accepted and dropped arbitrations
- governance for mandatory project-wide rules
- skills for specialized technology, workflow and format rules
- playbooks for reusable workflows
- decisions for durable accepted decisions
- specifications for confirmed expected behavior
- Kanban for implementation task state
- risks.md for confirmed project risks and their mitigation status

## Review Checks

Verify:

- consistency between context documents
- consistency between stack.yml and generated engineering sections
- compliance with governance rules
- compliance with relevant skills
- compliance with accepted decisions
- absence of reintroduced dropped arbitrations
- absence of open arbitrations presented as confirmed facts
- absence of invented requirements
- specification consistency
- Kanban format consistency
- references to existing files
- naming consistency
- architecture boundary compliance
- documentation alignment with implementation structure
- duplicated or contradictory project information
- obsolete references
- unsupported assumptions
- changes outside the requested scope
- risk register consistency
- absence of generic or invented risks
- validity of risk identifiers and supported values
- consistency between risks, mitigations, arbitrations and Kanban tasks
- closed risks remaining preserved in the Closed section

## Finding Severity

Use only:

- BLOCKING: prevents correct execution, generation or project use
- MAJOR: creates contradiction, invalid structure or significant project risk
- MINOR: creates limited inconsistency, ambiguity or maintainability cost

Do not assign severity without identifying a concrete impact.

## Finding Format

Each finding must contain:

- Severity
- Location
- Finding
- Evidence
- Required Correction

Use precise file paths and function, section or symbol names.

Do not report vague findings.

Do not report personal style preferences as defects.

## Correction Rules

Separate findings into:

- deterministic corrections
- corrections requiring user arbitration

A deterministic correction is directly required by an existing project rule, accepted decision or confirmed source of truth.

An arbitration is required when:

- multiple valid solutions exist
- the project source of truth is incomplete
- an open arbitration already covers the subject
- the correction would change project scope or architecture

Do not silently resolve an arbitration.

Do not silently modify accepted decisions.

Do not reintroduce dropped arbitrations.

## Modification Rules

Do not modify files unless the user explicitly requests corrections.

When corrections are requested:

- modify only deterministic findings
- preserve validated structure
- avoid unrelated cleanup
- avoid broad rewrites
- list every modified file
- leave arbitration items unchanged

## Specifications And Kanban

Verify that specifications:

- use confirmed requirements
- follow the specifications skill
- do not duplicate existing specification scope
- do not silently resolve open questions

Verify that the Kanban:

- follows the Kanban skill
- contains only supported columns and properties
- does not create tasks from open arbitrations
- does not use tasks as specifications
- references existing detail files

Do not generate specifications or Kanban tasks during a review unless explicitly requested.

## Risks

Verify that risks:

- follow the format defined in 00-META/context/risks.md
- use unique and stable RISK-XXX identifiers
- use supported area, impact and likelihood values
- are grounded in confirmed project context
- are not used as open decisions
- are not used as implementation tasks
- reference a Kanban task when mitigation requires confirmed implementation
- reference an open arbitration when mitigation requires an unresolved choice
- remain preserved when moved to Closed

## Expected Output

Produce only:

1. Review Scope
2. Validated Elements
3. Blocking Findings
4. Major Findings
5. Minor Findings
6. Required Arbitrations
7. Deterministic Corrections
8. Recommended Commit

Omit empty finding sections.

If no issue is found, state that no issue was identified within the reviewed scope.

Do not claim that unreviewed project areas are valid.