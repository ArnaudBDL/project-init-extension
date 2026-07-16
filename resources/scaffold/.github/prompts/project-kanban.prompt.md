---
description: "Generate and maintain the project kanban"
---

Read first:

- ../../00-META/context/framing.md
- ../../00-META/decisions/
- ../../00-META/skills/kanban/SKILL.md
- ../../03-PRODUCT/kanban/TASKS.md
- ../../00-META/context/open-arbitrations.md

## Goal

Maintain the project kanban using the Markdown Kanban Roadmap format.

## Source Of Truth

The project kanban is:

- ../../03-PRODUCT/kanban/TASKS.md

Detailed task files are stored in:

- ../../03-PRODUCT/kanban/tasks/

## Mandatory Rules

- Follow all rules defined in:
  ../../00-META/skills/kanban/SKILL.md
- Do not invent a custom kanban format.
- Do not invent unsupported columns.
- Do not invent unsupported task properties.
- Do not create alternative task boards.
- Do not duplicate kanban information elsewhere.

## Scope Rules

- Create tasks only for confirmed project work.
- Use framing.md as the primary source of project scope.
- Use specifications and ADRs when available.
- Do not invent features.
- Do not invent milestones.
- Do not create implementation tasks from open arbitrations.
- Accepted arbitrations may become tasks only after they are reflected in the appropriate project documents.
- Dropped arbitrations must not be reintroduced.

## Task Rules

- One task = one deliverable.
- Keep tasks reviewable.
- Avoid oversized tasks.
- Split large work into multiple tasks.
- Keep task titles concise and explicit.

## Status Rules

Task status is defined by its column.

Never add:

- status
- state
- progress

## Detail Files

When a task contains:

detail: ./tasks/T-XXX.md

the file must exist.

The detail file:

- must match the task id
- must contain implementation context when needed
- must not duplicate TASKS.md metadata

## Expected Output

When updating the kanban:

- explain created tasks
- explain modified tasks
- explain moved tasks
- explain removed tasks

Keep the board compatible with the Markdown Kanban Roadmap extension.