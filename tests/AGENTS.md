# Agents

This repository is structured for human and AI-assisted project work.

## Mandatory Reading Order

Before generating or modifying project files, AI agents must read:

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

Always read:

- 00-META/skills/README.md

Then read only the specialized skills relevant to the requested work.

Read a technology skill when:

- the selected technology is involved in the requested change
- code or configuration for that technology will be created or modified

Read 00-META/skills/specs/SKILL.md when:

- creating a specification
- modifying a specification
- reviewing specification structure or consistency

Read 00-META/skills/kanban/SKILL.md when:

- creating a Kanban task
- modifying a Kanban task
- moving a task between columns
- modifying TASKS.md
- creating or modifying a task detail file
- reviewing Kanban structure or consistency

Do not load specialized skills unrelated to the requested work.

When one task affects multiple specialized areas, read every relevant skill.

## Project Rules

- Do not invent missing project facts.
- Do not apply a technology skill that is not selected in 00-META/context/stack.yml.
- Keep frontend, server, shell and delivery concerns separated.
- Keep durable decisions in 00-META/decisions/.
- Keep runnable implementation code in 04-ENGINEERING/.
- Update context or governance documents when project truth changes.
- Open arbitrations are not confirmed project facts.
- Accepted arbitrations become project facts when reflected in the appropriate project documents.
- Dropped arbitrations must not be reintroduced unless explicitly requested by the user.
- Record confirmed project risks in 00-META/context/risks.md.
- Do not use risks.md for open decisions or implementation tasks.
- A mitigation requiring implementation must be tracked in the Kanban.
- A mitigation requiring an unresolved choice must be tracked as an open arbitration.

## Project Workflow

AI agents must use the following workflow according to the requested scope.

### 1. Framing

Before creating specifications, tasks or implementation code:

- verify that the requested scope is sufficiently confirmed
- read 00-META/context/framing.md
- read 00-META/context/open-arbitrations.md
- identify unresolved decisions affecting the requested scope
- do not create implementation work from open arbitrations

When project framing is incomplete or the user requests a framing interview, follow:

- .github/prompts/project-start.prompt.md
- the `/project-start` prompt command when available

The project-start prompt defines the mandatory framing interview discipline, including:

- factual and decision-oriented questions
- question limits per interview round
- document responsibility boundaries
- validation before confirmed project facts are written
- pending-question tracking between sessions
- stack and product-need tension reporting

Do not conduct an improvised project framing interview when the project-start prompt is available.

The entire project framing does not need to be complete when the requested scope is independently confirmed.

Blocking decisions for the requested scope must be resolved before continuing.

### 2. Specifications

A functional change must be covered by a specification in:

- 03-PRODUCT/specs/

Before creating or modifying a specification, follow:

- 00-META/skills/specs/SKILL.md
- .github/prompts/project-specs.prompt.md

A specification must use the Ready status before implementation tasks are created from it.

A new specification is not required for:

- documentation-only corrections
- technical corrections without functional impact
- bugs whose expected behavior is already documented
- internal maintenance without product impact

These exceptions must still follow the relevant playbook and project rules.

### 3. Kanban

Confirmed implementation work must be tracked in:

- 03-PRODUCT/kanban/TASKS.md

Before creating or modifying tasks, follow:

- 00-META/skills/kanban/SKILL.md
- .github/prompts/project-kanban.prompt.md

Implementation tasks created from a specification must reference the relevant specification in their detail file.

A task must:

- represent one concrete deliverable
- remain in BACKLOG until work begins
- contain only confirmed implementation work
- not duplicate the complete specification

### 4. Implementation

When implementation begins:

- move the active task from BACKLOG to DOING
- select the relevant playbook
- read the applicable technology skills
- modify only the confirmed task scope
- keep implementation code in 04-ENGINEERING/

Use:

- 00-META/playbooks/feature.md for feature work
- 00-META/playbooks/bugfix.md for defect correction
- 00-META/playbooks/migration.md for migrations

Do not start implementation when a blocking decision remains unresolved.

### 5. Review

When implementation is complete:

- move the task from DOING to REVIEW
- use .github/prompts/project-review.prompt.md
- follow 00-META/playbooks/review.md
- verify the implementation against the specification and acceptance criteria
- verify architecture, governance and applicable skills
- verify that no unrelated changes were introduced

Do not move a task directly from DOING to DONE unless the work is explicitly exempted from review because it is trivial and has no functional, architectural or security impact.

### 6. Completion

After successful review:

- move the task from REVIEW to DONE
- update the affected specification when necessary
- mark a specification as Implemented only when its complete scope is delivered and validated
- update Engineering documentation when commands, structure or usage changed
- create or update an ADR when implementation introduced a durable decision
- update project context only when the confirmed project truth changed

Do not update unrelated documents.

### Workflow Transitions

Workflow transitions are never automatic.

AI agents must:

- verify that the current stage is complete
- report blocking decisions
- recommend the next valid workflow
- wait for explicit user instruction before starting another major workflow

The standard sequence is:

Framing → Specification → Kanban → Implementation → Review → Completion

Do not skip a required stage.

## Engineering Rules

- Frontend code belongs in the generated client section when present.
- Backend/runtime code belongs in the generated server section when present.
- Platform shell code belongs in the generated shell section when present.
- Experimental work belongs in 05-LAB until reviewed and promoted.

- Legacy source code belongs in 09-LEGACY/codebase/.
- Legacy migration analysis and planning belong in 09-LEGACY/migration/.
- Target implementation code belongs in 04-ENGINEERING/.
- Do not modify legacy code without explicit migration work.
