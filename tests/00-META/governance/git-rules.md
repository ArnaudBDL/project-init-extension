# Git Rules

## Commit Format

Use the following format when proposing commits:

```bash
git add . && git commit -m "message"
```

## Commit Rules

- Keep commits focused.
- One commit should represent one coherent change.
- Avoid mixing unrelated refactors and feature changes.
- Do not commit temporary debug code.
- Do not commit generated noise unless it is expected project output.

## Message Rules

- Use concise commit messages.
- Use lowercase imperative style when possible.
- Describe the change, not the process.
- Avoid vague messages such as update, fix stuff or changes.
