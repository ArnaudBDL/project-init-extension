# Legacy Migration Workspace

This directory contains the analysis and planning documents required to migrate
the codebase stored in ../codebase.

## Purpose

The migration workspace describes the current legacy system, the intended target
state, migration constraints, identified risks and confirmed migration work.

It must be completed from evidence found in the legacy codebase and confirmed
project documentation.

## Documents

### project-overview.md

High-level description of the legacy application, its purpose, scope and known
operational context.

### source-tree.md

Inventory of the legacy source tree and the responsibilities of its main
directories.

### technology-inventory.md

Inventory of detected languages, frameworks, libraries, tools, storage systems
and runtime dependencies.

### architecture-analysis.md

Analysis of the current architecture, module boundaries, runtime flows, coupling
and structural constraints.

### business-rules.md

Confirmed business rules discovered in the legacy implementation or existing
documentation.

### external-dependencies.md

Inventory of external services, APIs, infrastructure, packages and integrations.

### technical-debt.md

Confirmed technical debt supported by concrete evidence from the legacy system.

### migration-risks.md

Risks specifically associated with analyzing, replacing or migrating the legacy
implementation.

### migration-plan.md

Confirmed migration strategy, phases, boundaries and validation approach.

### migration-tasks.md

Migration-specific work identified from the validated migration plan.

## Required Reading

Before analyzing or migrating legacy code, read:

- ../../00-META/context/stack.yml
- ../../00-META/context/architecture.md
- ../../00-META/context/open-arbitrations.md
- ../../00-META/context/risks.md
- ../../00-META/governance/architecture-rules.md
- ../../00-META/governance/naming-rules.md
- ../../00-META/governance/security-rules.md
- ../../00-META/playbooks/migration.md
- README.md
- project-overview.md
- source-tree.md
- technology-inventory.md
- architecture-analysis.md
- business-rules.md
- external-dependencies.md
- technical-debt.md
- migration-risks.md
- migration-plan.md
- migration-tasks.md

## Rules

- Do not invent facts about the legacy codebase.
- Support findings with concrete files, symbols, configuration or documented behavior.
- Clearly separate confirmed findings, assumptions and unresolved questions.
- Do not treat legacy architecture as the target architecture.
- Do not modify the imported legacy code without explicit migration work.
- Do not begin migration implementation before the affected scope is analyzed.
- Do not silently resolve migration arbitrations.
- Record durable migration decisions in 00-META/decisions.
- Record project-level risks in 00-META/context/risks.md.
- Keep target implementation code in 04-ENGINEERING.
- Keep this workspace aligned with the migration playbook.
