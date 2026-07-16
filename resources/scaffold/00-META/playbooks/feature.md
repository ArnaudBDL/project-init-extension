# Feature Playbook

## Purpose

This playbook defines how to add a new feature to the project.

It should be used when the task introduces new product behavior, a new screen,
a new module, a new workflow or a new user-facing capability.

## Required Reading

Before starting, read:

- 00-META/context/README.md
- 00-META/context/framing.md
- 00-META/context/open-arbitrations.md
- 00-META/context/identity.md
- 00-META/context/vision.md
- 00-META/context/stack.yml
- 00-META/governance/architecture-rules.md
- 00-META/governance/naming-rules.md
- 00-META/skills/specs/SKILL.md
- 00-META/skills/kanban/SKILL.md
- relevant 00-META/skills/*/SKILL.md files
- the related specification
- the related Kanban task

## Workflow

1. Verify that the feature scope is confirmed.
2. Verify that no open arbitration blocks the feature.
3. Verify that the functional scope is covered by a Ready specification.
4. Verify that a Kanban task references the specification.
5. Move the active task from BACKLOG to DOING.
6. Identify the affected product, design, client, server, shell and documentation layers.
7. Read all applicable technology skills.
8. Implement only the confirmed task scope.
9. Update affected documentation when behavior, structure or usage changed.
10. Move the completed task from DOING to REVIEW.
11. Apply the review playbook before completion.

## Architecture Rules

- Keep frontend, backend, shell and deployment responsibilities separated.
- Do not introduce mock data as final implementation.
- Do not hide important behavior behind unclear abstractions.
- Do not change visual structure unless explicitly requested.
- Prefer explicit, maintainable structure over clever shortcuts.

## Expected Output

A feature implementation should include only the necessary files and changes.

If code is requested, provide precise file locations and complete modified blocks
or complete files according to the user preference.

## Commit Format

```bash
git add . && git commit -m "add feature scope"
```
