# Client

This directory contains the client applications for this project.

## Generated Structure

{{#PROJECT_HAS_FRONTOFFICE}}
- {{PROJECT_SLUG}}-frontoffice: primary user-facing application
{{/PROJECT_HAS_FRONTOFFICE}}
{{#PROJECT_HAS_BACKOFFICE}}
- {{PROJECT_SLUG}}-backoffice: management and administration application
{{/PROJECT_HAS_BACKOFFICE}}

## Selected Frontend Stack

- {{PROJECT_FRONTEND_NAME}}

{{#PROJECT_HAS_FRONTEND_VARIANT}}
## Selected Frontend Variant

- {{PROJECT_FRONTEND_VARIANT_NAME}}
{{/PROJECT_HAS_FRONTEND_VARIANT}}

## Rules

- Keep frontoffice and backoffice responsibilities separated.
- Do not place backend runtime logic in client applications.
- Do not duplicate shared frontend behavior without an explicit reason.
- Keep client application boundaries explicit.

## Related META Files

- ../../00-META/context/stack.yml
- ../../00-META/context/architecture.md
- ../../00-META/governance/architecture-rules.md
- ../../00-META/skills/{{FRONTEND_STACK}}/SKILL.md