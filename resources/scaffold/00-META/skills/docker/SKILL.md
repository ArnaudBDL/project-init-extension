# Docker Skill

## Purpose

This skill defines how AI agents should work with Docker in this project.

It applies when:

```yaml
shell:
  web:
	stack: "docker"
```

## Role

Docker is the selected implementation technology for the web shell.

The web shell exposes the frontend client in a web environment and connects it
to the required runtime services.

Docker must not contain application business logic.

## Responsibilities

The Docker-based web shell can own:

- frontend web serving
- web runtime wiring
- environment wiring
- service startup
- container boundaries
- reverse proxy integration
- runtime connectivity
- web packaging
- deployment composition when required

## Architecture Boundaries

The frontend application belongs in:

```txt
client/
```

The Docker-based web shell belongs in:

```txt
shell/web/
```

Backend runtime code belongs in:

```txt
server/local/
server/remote/
```

Shared asset delivery belongs in:

```txt
server/assets/
```

The web shell must serve, expose and connect the client without duplicating
frontend, backend or shared asset responsibilities.

## Mandatory Rules

- Keep Docker configuration explicit.
- Keep environment-specific values externalized.
- Do not hardcode secrets.
- Separate development and production assumptions.
- Keep Docker concerns away from reusable business modules.
- Document exposed ports and service dependencies.
- Keep web serving concerns inside shell/web.
- Keep shared asset delivery concerns inside server/assets when enabled.
- Avoid overengineering orchestration for simple projects.

## Recommended Relationship

```txt
client/
	Frontend application

shell/web/
	Docker-based web shell

server/remote/
	Remote runtime when enabled

server/assets/
	Shared asset delivery when enabled
```

## Forbidden

- Do not place application business logic in Docker files.
- Do not place frontend application source code directly in shell/web.
- Do not duplicate backend runtime logic in shell/web.
- Do not move shared asset delivery responsibilities into shell/web.
- Do not commit secrets in environment files.
- Do not generate production credentials.
- Do not assume cloud infrastructure without explicit project context.

## Agent Instructions

Before generating Docker files, AI agents must read:

- 00-META/context/stack.yml
- 00-META/context/architecture.md
- 00-META/governance/architecture-rules.md
- 00-META/governance/security-rules.md
- 00-META/skills/docker/SKILL.md
