# Tauri Skill

## Purpose

This skill defines how AI agents should work with Tauri in this project.

It applies when:

```yaml
shell:
  desktop:
  stack: "tauri"
```

## Role

Tauri is a desktop shell.

It wraps the frontend client and connects it to the runtime environment.

Tauri must not become the business core of the application.

## Responsibilities

Tauri owns:

- desktop window lifecycle
- native integration
- filesystem permissions
- command bridge
- application packaging
- desktop capabilities
- controlled access to local runtime

## Mandatory Rules

- Keep Tauri as a shell layer.
- Keep business logic out of the shell.
- Keep runtime logic in server/local when a local server exists.
- Keep command handlers thin.
- Keep permissions explicit.
- Keep native integration separated from frontend code.
- Keep frontend and backend responsibilities separated.

## Recommended Relationship

```txt
shell/desktop/
	Tauri shell

client/
	Frontend application

server/local/
	Local runtime
```

## Forbidden

- Do not place reusable business modules directly inside the Tauri shell.
- Do not hardcode privileged filesystem access.
- Do not bypass documented permissions.
- Do not mix UI state and native runtime state without a clear boundary.

## Agent Instructions

Before generating Tauri code, AI agents must read:

- 00-META/context/stack.yml
- 00-META/governance/security-rules.md
- 00-META/skills/tauri/SKILL.md
