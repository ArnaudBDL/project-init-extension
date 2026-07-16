# Bugfix Playbook

## Purpose

This playbook defines how to investigate and fix a defect.

It should be used when something is broken, inconsistent, missing, incorrectly
generated or not aligned with the expected behavior.

## Required Reading

Before fixing, read:

- 00-META/context/stack.yml
- 00-META/governance/architecture-rules.md
- 00-META/governance/naming-rules.md
- relevant 00-META/skills/*/SKILL.md files
- 00-META/context/open-arbitrations.md
- 00-META/skills/kanban/SKILL.md
- 00-META/playbooks/review.md
- the related specification when expected behavior is documented there
- the related Kanban task

## Workflow

1. Identify the exact symptom.
2. Locate the smallest responsible area.
3. Avoid broad rewrites.
4. Fix the cause, not only the visible symptom.
5. Preserve existing structure unless the bug is caused by the structure itself.
6. Do not introduce unrelated improvements.
7. Re-check affected generated files or documentation.
8. Provide a focused commit message.
9. Confirm the expected behavior from existing documentation or specification.
10. Verify that no open arbitration blocks the correction.
11. Verify that the confirmed correction is tracked in the Kanban.
12. Move the active task from BACKLOG to DOING.
13. Locate the smallest responsible area.
14. Fix the cause without broad rewrites or unrelated changes.
15. Re-check affected behavior, generated files and documentation.
16. Move the completed task from DOING to REVIEW.
17. Apply the review playbook.

## Rules

- Do not guess missing file structure.
- Ask for the exact missing file only when required.
- Do not invent hidden dependencies.
- Do not replace a working pattern without explicit reason.
- Keep the fix minimal and understandable.

## Expected Output

A bugfix should clearly identify:

- the faulty area
- the correction
- the affected files
- any remaining limitation if relevant

## Commit Format

```bash
git add . && git commit -m "fix identified issue"
```
