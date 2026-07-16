# Copilot Instructions

This repository is structured for AI-assisted project work.

Copilot must treat 00-META as the project source of truth.

## Mandatory Reading Order

Before generating or modifying project files, read:

1. 00-META/context/README.md
2. 00-META/context/open-arbitrations.md
3. 00-META/context/risks.md
4. 00-META/context/identity.md
5. 00-META/context/vision.md
6. 00-META/context/stack.yml
7. 00-META/context/architecture.md
8. 00-META/context/framing.md
9. 00-META/governance/README.md
10. Relevant files in 00-META/governance/
11. 00-META/skills/README.md
12. Relevant skills in 00-META/skills/
13. Relevant playbook in 00-META/playbooks/

## Skill Selection

Always read 00-META/skills/README.md.

Load only the specialized skills relevant to the requested work.

- Read technology skills when the corresponding technology is involved.
- Read specs/SKILL.md when creating, modifying or reviewing specifications.
- Read kanban/SKILL.md when creating, modifying, moving or reviewing tasks.
- Read every relevant skill when a task affects multiple specialized areas.
- Do not load unrelated specialized skills.


## Project Boundaries

- Project truth belongs in 00-META/context.
- Mandatory rules belong in 00-META/governance.
- Specialized technology, workflow and structured-format constraints belong in 00-META/skills.
- Reusable workflows belong in 00-META/playbooks.
- Durable decisions belong in 00-META/decisions.
- Legacy source code belongs in 09-LEGACY/codebase/ when legacy migration is enabled.
- Legacy migration analysis and planning belong in 09-LEGACY/migration/ when legacy migration is enabled.
- Target implementation code belongs in 04-ENGINEERING/.
- Do not modify legacy code without explicit migration work.

## Agent Rules

- Do not invent missing project facts.
- Do not apply a technology skill that is not selected in 00-META/context/stack.yml.
- Keep frontend, server, shell and delivery concerns separated.
- Do not introduce unnecessary abstractions.
- Do not treat TODO placeholders as confirmed requirements.
- Update context or governance files when project truth changes.
- Open arbitrations are not confirmed project facts.
- Accepted arbitrations become project facts when reflected in the appropriate project documents.
- Dropped arbitrations must not be reintroduced unless explicitly requested by the user.
- Record confirmed project risks in 00-META/context/risks.md.
- Do not use risks.md for open decisions or implementation tasks.
- A mitigation requiring implementation must be tracked in the Kanban.
- A mitigation requiring an unresolved choice must be tracked as an open arbitration.

## Project Workflow

Follow the project lifecycle according to the requested scope:

1. Verify that framing is sufficient for the requested work.
2. Do not use open arbitrations as confirmed project facts.
3. Create or update a specification for functional changes.
4. Require a Ready specification before creating implementation tasks.
5. Track confirmed implementation work in the project Kanban.
6. Move the active task from BACKLOG to DOING when implementation begins.
7. Apply the relevant playbook and technology skills.
8. Keep implementation code in 04-ENGINEERING/.
9. Move completed implementation from DOING to REVIEW.
10. Apply the review prompt and review playbook.
11. Move validated work from REVIEW to DONE.
12. Synchronize only the affected specifications, documentation, decisions and
    context files.

A new specification is not required for:

- documentation-only corrections
- technical corrections without functional impact
- bugs whose expected behavior is already documented
- internal maintenance without product impact

Workflow transitions are not automatic.

Do not:

- implement work from an open arbitration
- skip unresolved blocking decisions
- use Kanban tasks as specifications
- move unreviewed non-trivial work directly to DONE
- update unrelated project documents
- start the next major workflow without explicit user instruction

## Engineering Rules

- Frontend code belongs in the generated client section when present.
- Backend/runtime code belongs in the generated server section when present.
- Platform shell code belongs in the generated shell section when present.
- Experimental work belongs in 05-LAB until reviewed and promoted.