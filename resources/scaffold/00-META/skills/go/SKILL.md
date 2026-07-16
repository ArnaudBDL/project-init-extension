# Go Skill

## Purpose

This skill defines how AI agents should work with Go in this project.

It applies when:

```yaml
server:
	stack: "go"
```

## Role

Go is the backend/runtime implementation language.

It owns:

- runtime composition
- backend modules
- local server execution
- remote server execution
- connectors
- domain services
- infrastructure adapters

## Mandatory Rules

- Organize packages by domain or responsibility.
- Keep modules isolated.
- Keep runtime entry points thin.
- Keep business logic out of transport handlers.
- Keep local and remote execution boundaries explicit.
- Avoid circular dependencies.
- Prefer clear interfaces at module boundaries.
- Keep configuration explicit.

## Recommended Structure

```txt
server/
├── modules/
├── local/
└── remote/
```

## Modules

Modules should contain reusable business/runtime logic.

Modules must not depend on whether they are executed locally or remotely.

## Local Runtime

Local runtime composes modules for embedded, desktop or local-first execution.

## Remote Runtime

Remote runtime exposes or runs modules as networked services or cloud processes.

## Forbidden

- Do not put business logic directly in HTTP handlers.
- Do not bind reusable modules to a single transport.
- Do not duplicate business logic between local and remote runtimes.
- Do not create microservices by default.
- Do not introduce unnecessary abstraction layers.

## Agent Instructions

Before generating Go code, AI agents must read:

- 00-META/context/stack.yml
- 00-META/governance/architecture-rules.md
- 00-META/governance/security-rules.md
- 00-META/skills/go/SKILL.md
