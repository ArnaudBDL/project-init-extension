# Shell

This directory contains platform shell code for this project.

A shell exposes or integrates the client with a target desktop, mobile or web environment.

## Selected Shells

{{#PROJECT_HAS_DESKTOP}} - Desktop: {{PROJECT_DESKTOP_SHELL_NAME}} {{/PROJECT_HAS_DESKTOP}} 
{{#PROJECT_HAS_MOBILE}} - Mobile: {{PROJECT_MOBILE_SHELL_NAME}} {{/PROJECT_HAS_MOBILE}} 
{{#PROJECT_HAS_WEB}} - Web: {{PROJECT_WEB_SHELL_NAME}} {{/PROJECT_HAS_WEB}}

## Generated Structure

{{#PROJECT_HAS_DESKTOP}} - desktop: desktop shell implementation {{/PROJECT_HAS_DESKTOP}} 
{{#PROJECT_HAS_MOBILE}} - mobile: mobile shell implementation {{/PROJECT_HAS_MOBILE}} 
{{#PROJECT_HAS_WEB}} - web: web exposure and runtime integration of the frontend client {{/PROJECT_HAS_WEB}}

## Development

TODO: define shell-level development commands after initializing the selected
shell technologies.

## Build / Package

TODO: define shell-level build or packaging commands.

## Rules

- Shells should not contain business modules directly.
- Shells should integrate, package and bridge.
- Runtime logic belongs to server/local or server/remote.
- Keep shell documentation aligned with the generated shell structure.

## Related META Files

- ../../00-META/context/stack.yml
- ../../00-META/governance/architecture-rules.md
- ../../00-META/skills/README.md