# Specifications Skill

This skill defines how AI agents must create and maintain project specifications.

## Mandatory Reading

Before creating or modifying a specification, read:

- 00-META/context/framing.md
- 00-META/context/open-arbitrations.md
- 00-META/context/identity.md
- 00-META/context/vision.md
- 00-META/context/stack.yml
- 00-META/decisions/
- 00-META/templates/specs/SPEC-TEMPLATE.md
- 03-PRODUCT/specs/README.md

Read relevant feature and UX flow documents when they exist.

## Source Rules

Specifications must use only:

- confirmed project context
- accepted decisions
- explicitly confirmed user requirements
- existing feature documents
- existing UX flow documents

Open arbitrations are not confirmed requirements.

Dropped arbitrations must not be reintroduced.

TODO placeholders are not confirmed requirements.

## File Naming

Specification files must use:

SPEC-XXX-short-title.md

Examples:

- SPEC-001-user-authentication.md
- SPEC-002-data-import.md
- SPEC-003-search-workflow.md

Identifiers must remain unique and stable.

## Specification Scope

One specification must describe one coherent functional scope.

A specification may describe:

- a feature
- a workflow
- a domain capability
- a system behavior
- an integration
- a technical capability with product impact

Do not combine unrelated scopes in one specification.

## Mandatory Sections

Every specification must contain:

- Status
- Summary
- Context
- Goals
- Requirements
- Acceptance Criteria
- Out Of Scope
- Dependencies
- Open Questions
- Related Files

## Status Values

Allowed status values:

- Draft
- Ready
- Implementing
- Implemented
- Deprecated

## Requirement Rules

Requirements must:

- be explicit
- be testable when possible
- describe expected behavior
- avoid implementation details unless technically required
- use stable identifiers

Requirement identifiers must use:

REQ-001
REQ-002
REQ-003

## Acceptance Criteria Rules

Acceptance criteria must:

- correspond to documented requirements
- describe observable validation conditions
- avoid introducing new requirements
- use checklist items

## Relationship With Features

Feature documents explain:

- what the capability is
- why it exists
- the value it provides

Specifications define:

- precise expected behavior
- rules
- constraints
- acceptance criteria

Do not duplicate full specifications in feature documents.

## Relationship With UX Flows

UX flow documents describe user journeys and transitions.

Specifications may reference UX flows but must not duplicate complete flow documentation.

## Relationship With Kanban

Specifications define expected behavior.

Kanban tasks define execution work.

Do not use TASKS.md as a specification.

Do not create Kanban tasks from:

- unconfirmed requirements
- open questions
- open arbitrations

## Agent Rules

- Do not invent requirements.
- Do not silently resolve open questions.
- Do not silently resolve open arbitrations.
- Do not create empty specification files.
- Do not duplicate an existing specification.
- Update an existing specification when its scope already covers the requested change.
- Keep implementation tasks outside specification files.
