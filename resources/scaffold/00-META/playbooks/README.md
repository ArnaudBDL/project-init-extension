# Playbooks

This directory contains reusable workflows for humans and AI agents.

Playbooks describe how work should be approached, sequenced and reviewed.

They are not technology-specific rules.
Technology-specific constraints belong in 00-META/skills.

They are not project facts.
Current project facts belong in 00-META/context.

They are not historical decisions.
Historical decisions belong in 00-META/decisions.

## Documents

### feature.md

Workflow for designing and implementing a new feature.

### bugfix.md

Workflow for investigating and fixing a defect.

### review.md

Workflow for reviewing generated or modified work.

### release.md

Workflow for preparing a release.

### migration.md

Workflow for migrating architecture, code, data or tooling.

## Agent Rules

- AI agents must select the playbook that matches the task.
- AI agents must read context and governance before applying a playbook.
- AI agents must read relevant skills before generating technology-specific code.
- AI agents must not skip review steps when modifying project structure or architecture.
