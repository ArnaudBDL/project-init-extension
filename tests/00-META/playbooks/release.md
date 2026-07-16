# Release Playbook

## Purpose

This playbook defines how to prepare a release.

It should be used when the project reaches a stable checkpoint, delivery point,
tagged version or deployable state.

## Required Reading

Before preparing a release, read:

- 00-META/context/identity.md
- 00-META/context/stack.yml
- 00-META/governance/git-rules.md
- 00-META/governance/security-rules.md
- relevant 00-META/skills/*/SKILL.md files

## Workflow

1. Verify the project identity and stack.
2. Verify that generated structure matches selected targets.
3. Verify that documentation is current.
4. Check for temporary code, TODO misuse and fake data.
5. Check security-sensitive files and generated docs.
6. Prepare release notes if applicable.
7. Propose a release commit or tag message.

## Rules

- Do not release with known temporary implementation unless explicitly accepted.
- Do not include secrets or credentials.
- Do not treat prototypes as production code.
- Do not include generated noise that has no project value.
- Keep release notes factual.

## Expected Output

A release preparation should identify:

- release scope
- included changes
- excluded work
- known risks
- validation status

## Commit Format

```bash
git add . && git commit -m "prepare release"
```
