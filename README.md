# Project Builder

Project Builder is an AI-first Visual Studio Code extension that generates complete, structured project workspaces from an interactive interview.

It creates the project documentation, governance rules, technical context, AI agent instructions, skills, playbooks, specifications, prompts and implementation directories required to start working immediately.

## Features

- Interactive project configuration directly inside Visual Studio Code
- Frontend stack and variant selection
- Backend stack and framework selection
- Local, remote and asset server target selection
- Database and search engine selection
- Desktop, mobile and web shell selection
- Legacy project support
- AI-first project documentation
- Generated GitHub Copilot instructions and prompts
- Technology-specific skill documentation
- Project governance and decision records
- Kanban and specification workflows
- Existing scaffold detection and completion
- Existing files are preserved during generation

## Requirements

- Visual Studio Code 1.125.0 or later

## Installation

Project Builder is distributed as a local VSIX package.

Install it from the command line:

```bash
code --install-extension project-builder-0.0.1.vsix
```

You can also install it directly from Visual Studio Code:

1. Open the Extensions view.
2. Open the Extensions menu.
3. Select `Install from VSIX...`.
4. Select the generated `project-builder-0.0.1.vsix` file.

## Usage

Open the workspace folder in which the project scaffold must be generated.

Open the Command Palette:

```text
Cmd + Shift + P
```

Run:

```text
Project Builder
```

Complete the interactive interview.

Project Builder displays a summary before generating the workspace.

After generation, the extension reports:

- The number of files created
- The number of existing files preserved

It also provides actions to open:

```text
.github/prompts/project-start.prompt.md
```

or:

```text
README.md
```

## Existing Scaffold Completion

When the current workspace already contains:

```text
00-META/context/stack.yml
```

Project Builder detects the existing scaffold.

The extension loads the existing project profile from `stack.yml` and proposes to complete the scaffold.

In completion mode:

- The interactive interview is not restarted
- The existing technical profile remains the source of truth
- Only missing files are generated
- Existing files are preserved

This prevents missing documents from being generated with choices that differ from the original project configuration.

## Generated Workspace

Depending on the selected project profile, Project Builder can generate:

```text
.github/
00-META/
01-FOUNDATION/
02-PRODUCT/
03-UX/
04-ENGINEERING/
05-DATA/
06-AI/
07-DELIVERY/
08-MARKETING/
09-LEGACY/
AGENTS.md
README.md
```

The exact structure depends on the technologies, runtime targets, data services, shells and legacy options selected during the interview.

## Generated AI Resources

Project Builder creates resources designed for AI-assisted development, including:

- Agent instructions
- GitHub Copilot instructions
- Project context
- Engineering rules
- Governance rules
- Technology-specific skills
- Project playbooks
- Specification templates
- Decision records
- Project-start prompts

The generated workspace is intended to be immediately usable by developers and AI coding agents.

## File Preservation

Project Builder never overwrites an existing file during scaffold generation.

When a generated destination already exists, the file is skipped and reported as preserved.

This applies to both:

- New project generation
- Existing scaffold completion

## License

This extension is intended for private use.