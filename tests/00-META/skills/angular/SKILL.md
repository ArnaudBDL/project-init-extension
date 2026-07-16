# Angular Skill

## Purpose

This skill defines how AI agents should work with Angular in this project.

It applies when:

```yaml
frontend:
	stack: "angular"
```

## Role

Angular is the frontend application framework.

It owns:

- screens
- routes
- UI state
- components
- frontend services
- user interactions

Angular must not own backend runtime logic.

## Mandatory Rules

- Prefer standalone components.
- Use feature-first organization.
- Keep UI components focused on presentation and interaction.
- Keep business/runtime logic outside components.
- Keep shared utilities explicit and limited.
- Avoid generic catch-all folders when a domain-specific name exists.
- Keep routing readable and predictable.
- Keep frontend state separate from backend runtime execution.

## Recommended Structure

```txt
client/
└── src/
		└── app/
				├── core/
				├── shared/
				├── features/
				├── layouts/
				└── routes/
```

## Forbidden

- Do not place backend runtime logic in Angular.
- Do not hardcode production data.
- Do not generate fake services as final implementation.
- Do not hide important UI behavior in unclear abstractions.
- Do not change visual structure unless explicitly requested.

## Agent Instructions

Before generating Angular code, AI agents must read:

- 00-META/context/stack.yml
- 00-META/governance/architecture-rules.md
- 00-META/governance/naming-rules.md
- 00-META/skills/angular/SKILL.md
