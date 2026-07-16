# Security Rules

## Baseline Rules

- Do not commit secrets.
- Do not hardcode credentials.
- Do not store tokens in generated documentation.
- Do not expose private infrastructure details unless explicitly required.

## Configuration

- Sensitive values must be externalized.
- Environment-specific values must not be mixed with source code.
- Local development configuration must remain clearly separated from production configuration.

## AI Agent Rules

- AI agents must not invent secrets, credentials or private endpoints.
- AI agents must not generate insecure defaults without clearly marking them as temporary.
- AI agents must prefer safe placeholders when security-sensitive values are required.

## Generated Projects

- Security assumptions must be documented.
- Authentication and authorization rules must be defined before production implementation.
- External integrations must be reviewed before being treated as trusted.
