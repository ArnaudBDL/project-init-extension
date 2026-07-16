# Shell

This directory contains platform shell code for this project.

A shell exposes or integrates the client with a target desktop, mobile or web environment.

## Selected Shells

 - Desktop: Tauri
 - Mobile: Capacitor
 - Web: Docker

## Generated Structure

 - desktop: desktop shell implementation
 - mobile: mobile shell implementation
 - web: web exposure and runtime integration of the frontend client

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
