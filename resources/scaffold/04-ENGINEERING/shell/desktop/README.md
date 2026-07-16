# Desktop Shell

This directory contains the desktop shell implementation for this project.

## Selected Shell

- {{PROJECT_DESKTOP_SHELL_NAME}}

## Role

The desktop shell wraps the client application and connects it to the selected
runtime environment.

## Development

TODO: initialize the desktop shell project.

## Run Development

TODO: define the desktop shell development command.

## Build / Package

TODO: define the desktop packaging command.

## Responsibilities

The selected desktop shell owns:

- window lifecycle
- native integration
- permissions
- filesystem access when required
- runtime bridge
- packaging
- desktop-specific capabilities

## Relationship With Other Sections

- client contains the frontend application.
- server/local contains the local runtime when enabled.
- shell/desktop contains only desktop shell integration.

## Rules

- Do not place business modules directly in the desktop shell.
- Keep native integration separated from reusable frontend and backend code.

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md
- ../../../00-META/skills/{{SHELL_DESKTOP}}/SKILL.md
