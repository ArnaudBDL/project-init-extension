# HTML CSS JS Skill

## Purpose

This skill defines how AI agents should work with a static frontend based on
HTML, CSS and JavaScript.

It applies when:

```yaml
frontend:
  stack: "html-js-css"
```

## Role

HTML/CSS/JS is used for simple static frontend implementations.

It can be used for:

- static pages
- prototypes
- lightweight interfaces
- documentation-driven frontends
- non-framework UI experiments

## Important Distinction

Static JSON is not a frontend stack.

Static JSON is a content or data mode.

If static JSON becomes necessary later, it should be modeled separately from
FRONTEND_STACK.

## Mandatory Rules

- Keep HTML structure explicit.
- Keep CSS readable and organized.
- Keep JavaScript behavior separated from markup when possible.
- Avoid unnecessary framework-like abstractions.
- Avoid hidden state management.
- Keep assets and data references clear.

## Forbidden

- Do not simulate a framework architecture unless explicitly required.
- Do not mix temporary prototype logic with durable implementation code.
- Do not hardcode production data as final content.
