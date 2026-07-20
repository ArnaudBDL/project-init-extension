# Tauri

## Purpose

This skill defines the mandatory engineering rules for Tauri work in this project.

## Role in This Project

Tauri is the selected desktop shell, wrapping the frontend client and connecting it to the runtime environment. It owns the desktop window lifecycle, native integration, filesystem permissions, command bridge, application packaging and controlled access to the local runtime. Its implementation must remain consistent with `00-META/context/stack.yml`, the active specification, architectural decisions and the existing codebase.

## Recommended Relationship

```txt
shell/desktop/
	Tauri shell

client/
	Frontend application

server/local/
	Local runtime
```

## Mandatory Rules

- Keep Tauri as a shell layer; business logic must remain out of the shell.
- Keep runtime logic in server/local when a local server exists.
- Keep command handlers thin and permissions explicit.
- Keep native integration separated from frontend code.
- Keep frontend and backend responsibilities separated.
- Validate all external input at the boundary where it enters the system.
- Preserve existing project conventions unless an approved specification changes them.
- Keep code, configuration, tests and documentation synchronized.
- Run the relevant formatter, build, validation and test commands before completion.

## Forbidden

- Do not place reusable business modules directly inside the Tauri shell.
- Do not hardcode privileged filesystem access or bypass documented permissions.
- Do not mix UI state and native runtime state without a clear boundary.
- Do not introduce unrelated dependencies or architectural layers.
- Do not hardcode credentials, tokens or environment-specific secrets.
- Do not claim validation succeeded unless the command was actually executed successfully.

## Agent Instructions

Before changing Tauri code:

1. Read this skill completely.
2. Read `00-META/context/stack.yml` and the active specification.
3. Inspect the existing implementation and tests.
4. Follow the established project structure and naming.
5. Make the smallest coherent change that satisfies the specification.
6. Validate the affected code with the project commands.
7. Report assumptions, limitations and any validation that could not be executed.

