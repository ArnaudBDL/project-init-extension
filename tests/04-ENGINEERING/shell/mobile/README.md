# Mobile Shell

This directory contains the mobile shell implementation for this project.

## Selected Shell

- Capacitor

## Role

The mobile shell wraps or integrates the client application for mobile environments according to the selected CLI interview answers.

## Development

TODO: initialize the mobile shell project.

## Run Development

TODO: define the mobile shell development command.

## Build / Package

TODO: define the mobile build or packaging command.

## Responsibilities

The selected mobile shell owns:

- mobile platform integration
- application lifecycle
- platform permissions
- device APIs when required
- native bridge integration
- mobile packaging

## Relationship With Other Sections

- client contains the frontend application.
- shell/mobile contains only selected mobile shell integration.
- server/local or server/remote may provide runtime services when enabled.
- reusable business logic must not live directly in the mobile shell.

## Rules

- Keep mobile-specific integration isolated.
- Do not duplicate frontend business behavior.
- Do not place backend runtime logic in the mobile shell.

## Related META Files

- ../../../00-META/context/stack.yml
- ../../../00-META/governance/architecture-rules.md
- ../../../00-META/governance/security-rules.md
- ../../../00-META/skills/capacitor/SKILL.md
