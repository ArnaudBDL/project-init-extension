---
description: "Generate and maintain project specifications from confirmed requirements"
---

Read first:

- ../../00-META/context/framing.md
- ../../00-META/context/open-arbitrations.md
- ../../00-META/context/identity.md
- ../../00-META/context/vision.md
- ../../00-META/context/stack.yml
- ../../00-META/decisions/
- ../../00-META/skills/specs/SKILL.md
- ../../00-META/templates/specs/SPEC-TEMPLATE.md
- ../../03-PRODUCT/specs/README.md
- ../../03-PRODUCT/features/
- ../../03-PRODUCT/ux-flows/

## Goal

Create or update project specifications from confirmed project requirements.

## Source Of Truth

Active specifications belong in:

- ../../03-PRODUCT/specs/

Specification rules are defined in:

- ../../00-META/skills/specs/SKILL.md

## Mandatory Rules

- Use only confirmed requirements.
- Do not invent missing requirements.
- Do not treat TODO placeholders as confirmed requirements.
- Do not silently decide open arbitrations.
- Do not reintroduce dropped arbitrations.
- Do not create a duplicate specification.
- Update an existing specification when its scope already covers the requested change.
- Follow the required specification structure and naming convention.

## Workflow

1. Read the confirmed project context.
2. Read accepted decisions relevant to the requested scope.
3. Check open-arbitrations.md for unresolved decisions.
4. Search existing specifications for overlapping scope.
5. Identify confirmed requirements.
6. Identify missing decisions and open questions.
7. Create or update the smallest coherent specification.
8. Keep implementation task planning outside the specification.

## Specifications And Kanban

Do not create Kanban tasks unless explicitly requested.

When Kanban work is requested:

- use only Ready specifications
- follow ../../00-META/skills/kanban/SKILL.md
- create implementation tasks in ../../03-PRODUCT/kanban/TASKS.md

## Expected Output

Before modifying files, report:

- existing specification affected, if any
- confirmed requirements
- missing decisions
- open arbitrations affecting the scope
- target specification file

Then create or update the specification only when enough confirmed information exists.

If required information is missing, identify the smallest decisions needed and stop before inventing content.