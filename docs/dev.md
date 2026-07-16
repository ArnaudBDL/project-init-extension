# Project Builder Development

This document contains the development, debugging, build and packaging instructions for the Project Builder Visual Studio Code extension.

## Requirements

- Node.js 22 or later
- npm 10 or later
- Visual Studio Code 1.125.0 or later

## Install Dependencies

```bash
npm install
```

The installation must generate and update:

```text
node_modules/
package-lock.json
```

The `package-lock.json` file must remain versioned to keep installations and packaging reproducible.

## Build

Compile the TypeScript source:

```bash
npm run build
```

Generated JavaScript files are written to:

```text
dist/
```

## Watch Mode

Run the TypeScript compiler in watch mode:

```bash
npm run watch
```

## Run the Extension

Build the extension first:

```bash
npm run build
```

Then press:

```text
F5
```

Visual Studio Code opens a new window named:

```text
Extension Development Host
```

The development host must be opened with a workspace folder because Project Builder generates files in the current workspace.

## Configure the Development Workspace

The debug configuration can open a specific workspace automatically.

Example `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Run Project Builder",
      "type": "extensionHost",
      "request": "launch",
      "args": [
        "--extensionDevelopmentPath=${workspaceFolder}",
        "/Users/arnaud/Developer/Cargo-SDW"
      ],
      "outFiles": [
        "${workspaceFolder}/dist/**/*.js"
      ],
      "preLaunchTask": "npm: build"
    }
  ]
}
```

Replace the target workspace path when testing generation in another project.

## Test the Extension

In the Extension Development Host:

1. Open the Command Palette with `Cmd + Shift + P`.
2. Run the Project Builder command.
3. Complete the interactive interview.
4. Confirm the generation summary.
5. Verify the generated scaffold in the current workspace.

For an existing scaffold test, ensure the workspace contains:

```text
00-META/context/stack.yml
```

Run the command again and verify that Project Builder:

1. Detects the existing scaffold.
2. Loads the existing profile.
3. Requests confirmation.
4. Generates only missing files.
5. Preserves every existing file.

## Project Structure

```text
.
├── .vscode/
│   ├── launch.json
│   └── tasks.json
├── docs/
│   └── README.md
├── resources/
│   ├── scaffold/
│   ├── skills/
│   └── templates/
├── src/
│   ├── commands/
│   ├── generators/
│   ├── interview/
│   ├── models/
│   ├── registries/
│   ├── services/
│   └── extension.ts
├── dist/
├── package.json
├── package-lock.json
├── tsconfig.json
└── README.md
```

## Source Responsibilities

### `src/commands/`

Contains extension commands and command-level orchestration.

The new-project command is responsible for selecting between:

- New project generation
- Existing scaffold completion

### `src/interview/`

Contains the individual steps of the interactive project interview.

Each step is responsible for one project configuration decision.

### `src/models/`

Contains shared TypeScript models, including the project profile.

### `src/registries/`

Contains supported technology and platform definitions.

Registries provide stable keys and display labels for:

- Frontend stacks
- Frontend variants
- Backend stacks
- Backend frameworks
- Databases
- Search engines
- Desktop shells
- Mobile shells
- Web shells

### `src/services/`

Contains reusable application services, including:

- Workspace resolution
- Filesystem operations
- Template rendering
- Template-context generation
- Project-profile creation
- Existing scaffold detection
- Existing project-profile loading

### `src/generators/`

Contains the project generation pipeline.

The generator resolves resources, renders templates and writes generated files without overwriting existing files.

### `resources/`

Contains all static resources embedded in the extension package.

This includes:

- Scaffold files
- Markdown templates
- Technology-specific skill files
- GitHub Copilot instructions
- Project prompts
- Governance documents
- Playbooks
- Specification templates

## Project Profile

The project profile is the internal source used to create the template context.

For new projects, it is populated by the interactive interview.

For existing projects, it is reconstructed from:

```text
00-META/context/stack.yml
```

The loader must use stable keys from the YAML document and must not reconstruct technical choices from human-readable labels.

## Template Context

The template context converts the project profile into values consumed by resource templates.

It includes:

- Project identity
- Feature-presence flags
- Frontend values
- Backend values
- Runtime targets
- Data services
- Shell targets
- Legacy status
- Generated technical sections
- Active skills
- Generated skill directories

Every variable referenced by a template must exist in the template context.

Conditional template variables must be explicit string booleans:

```text
true
false
```

## Template Validation

Template variables and context keys must remain synchronized.

Useful search command:

```bash
grep -Rho '{{[A-Z0-9_]*}}' resources \
    | sed 's/[{}]//g' \
    | sort -u
```

Conditional variables can be inspected with:

```bash
grep -Rho '{{#if [A-Z0-9_]*}}' resources \
    | sed 's/{{#if*//; s/}}//' \
    | sort -u
```

A*l returned variables must be provi*ed by the appropriate template con*ext.

## Existing File Policy

The*filesystem service must never over*rite an existing generated destina*ion.

Generation reports must dist*nguish between:

- Created files
-*Skipped existing files

The existi*g scaffold completion flow relies *n this policy to generate missing *iles safely.

## Clean

Remove com*iled files:

```bash
rm -rf dist
`*`

Rebuild afterward:

```bash
npm*run build
```

## Reproducible Ins*allation

Install the exact depend*ncy tree from `package-lock.json`:*
```bash
npm ci
```

Validate the *ypeScript build:

```bash
npm run *uild
```

## Package the Extension*
The project uses the local `@vsco*e/vsce` development dependency.

P*ckage through the npm script:

```*ash
npm run package
```

The packa*e script must execute the local VSCE installation:

```json
{
  "scripts": {
    "package": "npx @vscode/vsce package"
  }
}
```

Expected output:

```text
project-builder-0.0.1.vsix
```

The package version comes from:

```json
{
  "version": "0.0.1"
}
```

in `package.json`.

## VS Code API Version Consistency

The minimum VS Code version and the installed VS Code type definitions must remain compatible.

Example:

```json
{
  "engines": {
    "vscode": "^1.125.0"
  },
  "devDependencies": {
    "@types/vscode": "^1.125.0"
  }
}
```

VSCE rejects packaging when `@types/vscode` targets an API version newer than `engines.vscode`.

## Verify Package Contents

A successful TypeScript build does not verify that static resources are embedded in the VSIX package.

After packaging, inspect the archive:

```bash
unzip -l project-builder-0.0.1.vsix
```

Verify that it contains:

```text
extension/dist/
extension/resources/
extension/package.json
extension/README.md
```

The packaged extension must include all templates, scaffold resources and skill files required at runtime.

## Install the Local VSIX

```bash
code --install-extension project-builder-0.0.1.vsix
```

To replace an already installed version:

```bash
code --install-extension project-builder-0.0.1.vsix --force
```

Restart or reload Visual Studio Code after installation if the new version is not activated immediately.

## Complete Validation Sequence

Run the complete local validation with:

```bash
rm -rf dist
npm ci
npm run build
npm run package
unzip -l project-builder-0.0.1.vsix
code --install-extension project-builder-0.0.1.vsix --force
```

Then open a test workspace and validate:

- New project interview
- Scaffold generation
- Generated project-start prompt
- Generated root README
- Existing file preservation
- Existing scaffold detection
- Existing profile loading
- Missing-file completion