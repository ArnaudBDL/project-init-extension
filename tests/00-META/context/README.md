# Context

This directory contains the current source of truth for the project.

It is intended to be read first by AI agents before modifying, generating or reviewing project files.

## Documents

### identity.md

Describes the project identity: name, slug, description, mission and audience.

### vision.md

Describes the product direction, target audience, value proposition and framing questions that still need to be answered.

### stack.yml

Describes the selected technical stack in a machine-readable format.

This document is used by AI agents to understand which frontend, backend, runtime, shell and delivery targets are active.

### architecture.md

Describes the generated architecture in human-readable form.

It explains how frontend, server, runtime and shell sections relate to each other according to the CLI interview answers.

### framing.md

Tracks framing status, confirmed decisions, unresolved questions and the expected AI interview scope.

### open-arbitrations.md

Tracks unresolved project decisions, accepted arbitrations and dropped proposals.

Open arbitrations are not project facts.

### risks.md

Tracks confirmed project risks, their impact, likelihood, mitigation and resolution state.

Risks are not decisions, tasks or confirmed outcomes.

## Rules

- Context files describe the current state of the project.
- Context files should remain concise and stable.
- Detailed implementation rules belong in 00-META/governance.
- Specialized technology, workflow and structured-format constraints belong in 00-META/skills.
- Durable decisions belong in 00-META/decisions.
