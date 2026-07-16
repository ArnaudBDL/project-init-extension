# Skills

This directory contains specialized instructions for AI agents.

Technology skills are generated from the CLI interview answers.

Workflow and format skills may be generated independently when they define mandatory project conventions.

Each skill directory describes how an AI agent must work with a selected technology, runtime, shell, workflow or structured format.

## Role

Skills provide specialized implementation, workflow or format constraints.

They are not the project identity.

They are not global architecture rules.

They are not historical decisions.

## Relationship With Other META Directories

- 00-META/context describes the current project state.
- 00-META/governance defines mandatory project-wide rules.
- 00-META/skills defines specialized technology, workflow and structured-format rules.
- 00-META/playbooks defines reusable workflows.
- 00-META/decisions stores durable project decisions.

## Agent Rules

- AI agents must read the relevant skill before generating code for a selected technology.
- AI agents must combine skills with governance rules.
- AI agents must not apply a technology skill that is not selected in context/stack.yml.
- Workflow and format skills apply only when their documented project area is modified or reviewed.
- AI agents must not invent technology constraints that are not documented here.

## Active Skills

{{ACTIVE_SKILLS}}

## Generated Skill Directories

{{GENERATED_SKILL_DIRECTORIES}}