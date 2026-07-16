# Decisions

This directory stores durable project decisions.

A decision records an important architectural, technical, product or workflow
choice that should remain understandable over time.

## ADR Convention

Use one file per decision.

Naming format:

```txt
ADR-001-short-title.md
ADR-002-short-title.md
ADR-003-short-title.md
```

## Recommended Status Values

- Proposed
- Accepted
- Deprecated
- Superseded

## Template

Use:

```txt
../templates/decisions/ADR-TEMPLATE.md
```

## Agent Rules

- AI agents must create or update an ADR when changing a major architectural, product or workflow decision.
- AI agents must not silently invalidate an accepted decision.
- AI agents must reference affected context, governance, skill or engineering files when relevant.
- AI agents must keep ADRs concise and factual.
- AI agents must clearly separate context, considered options, final decision and consequences.
