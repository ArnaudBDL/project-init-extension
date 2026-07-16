# Kanban Skill

This project uses the Markdown Kanban Roadmap format.

Before modifying the kanban, read:

- 03-PRODUCT/kanban/TASKS.md
- 00-META/templates/kanban/TASKS-TEMPLATE.md
- 00-META/templates/kanban/TASK-TEMPLATE.md

## Allowed Columns

- BACKLOG
- DOING
- REVIEW
- DONE
- PAUSED



## Allowed Properties

- id
- tags
- priority
- workload
- milestone
- start
- due
- updated
- detail
- defaultExpanded



## Allowed Priority Values

- low
- medium
- high



## Allowed Workload Values

- Easy
- Medium
- Hard
- Extreme



## Task Identifiers

Tasks must use:

- T-001
- T-002
- T-003

Format:

T-XXX


## Detail Files

A task may reference:

detail: ./tasks/T-XXX.md

If a detail file is referenced:

- the file must exist
- the filename must match the task id
- the title must match the task id


## Status Rules

Task status is defined by its column.

Never create:

- status
- state
- progress


## Definition Of Ready

A task is ready to move from BACKLOG to DOING only when:

- the expected result is explicit
- the task scope is confirmed
- acceptance criteria are verifiable
- known dependencies and blockers are documented
- no open arbitration blocks the task
- the related specification is Ready when a specification is required
- the task detail file exists when referenced
- the task represents one concrete deliverable

A task that does not meet these conditions:

- must remain in BACKLOG
- must not move to DOING
- must not trigger implementation work

Missing information must remain explicit.

AI agents must not silently complete missing task information or resolve a
blocking arbitration.


## Milestone Format

sprint-YY-MM_N

Examples:

- sprint-26-07_1
- sprint-26-07_2
- sprint-26-08_1


## Agent Rules

- Do not invent unsupported properties.
- Do not invent unsupported columns.
- Keep ids unique.
- Keep detail references valid.
- Move tasks between columns to change status.
- Do not create orphan detail files.
