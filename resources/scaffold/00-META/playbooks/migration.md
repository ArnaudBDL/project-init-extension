# Migration Playbook

## Purpose

This playbook defines how to perform a migration.

It should be used when changing architecture, folder structure, framework,
runtime, language, storage strategy, tooling or generated documentation model.

## Required Reading

Before migrating, read:

- 00-META/context/stack.yml
- 00-META/governance/architecture-rules.md
- 00-META/governance/naming-rules.md
- 00-META/governance/security-rules.md
- relevant 00-META/skills/*/SKILL.md files
- 00-META/decisions when available

When legacy migration is enabled, also read:

- 09-LEGACY/migration/README.md
- 09-LEGACY/migration/project-overview.md
- 09-LEGACY/migration/source-tree.md
- 09-LEGACY/migration/technology-inventory.md
- 09-LEGACY/migration/architecture-analysis.md
- 09-LEGACY/migration/business-rules.md
- 09-LEGACY/migration/external-dependencies.md
- 09-LEGACY/migration/technical-debt.md
- 09-LEGACY/migration/migration-risks.md
- 09-LEGACY/migration/migration-plan.md
- 09-LEGACY/migration/migration-tasks.md

## Workflow

1. Identify the confirmed migration scope.
2. Analyze the source state from concrete legacy code and configuration evidence.
3. Complete the affected legacy migration analysis documents.
4. Identify unresolved decisions and migration risks.
5. Confirm the target state from 00-META context and accepted decisions.
6. Define and validate migration-plan.md.
7. Derive reviewable migration work in migration-tasks.md.
8. Create matching project Kanban tasks for confirmed implementation work.
9. Move the active Kanban task to DOING before implementation.
10. Implement target code only in 04-ENGINEERING/.
11. Validate preserved behavior, data, integrations and rollback conditions.
12. Move completed work to REVIEW and apply the review playbook.

## Rules

- Do not migrate by rewriting blindly.
- Preserve validated decisions unless explicitly changed.
- Do not keep obsolete files without reason.
- Do not duplicate old and new systems unless a transition period is intentional.
- Keep migration steps reviewable.

## Expected Output

A migration should clearly state:

- source state
- target state
- files changed
- files removed
- compatibility impact
- follow-up cleanup if needed

## Commit Format
 
```bash
git add . && git commit -m "migrate source to target"
```
