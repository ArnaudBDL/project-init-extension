# Docker

## Purpose

This skill defines the mandatory rules for using Docker as the web runtime shell of this project.

Docker provides the containerized execution, integration, packaging and delivery envelope used to expose the application in a web environment.

## Role in This Project

Docker is intentionally modeled as a web shell in Project Builder.

In this project, the term `shell` does not mean a user-interface framework.

A shell is the platform-specific execution and delivery envelope surrounding the application:

- Desktop shells package and integrate the application for desktop platforms.
- Mobile shells package and integrate the application for mobile platforms.
- The Docker web shell packages, connects, executes and exposes the application for web deployment.

Docker is not the frontend technology.

The frontend remains implemented by the selected frontend stack, such as Angular, React, Vue or another supported frontend technology.

Docker is not the backend implementation.

The backend remains implemented by the selected backend/runtime stack, such as Go, Node.js, PHP, Python or another supported backend technology.

Docker must expose and connect the selected application components without duplicating their responsibilities.

For example:

```yaml
frontend:
  stack: "angular"

server:
  stack: "go"

shell:
  web:
    stack: "docker"
```

In this configuration:

- Angular owns the web user interface.
- Go owns the backend/runtime implementation.
- Docker owns the containerized web execution and delivery envelope.

The placement of Docker under `shell.web` is a deliberate product-modeling decision.

It must not be interpreted as Docker being a frontend framework or user-interface technology.

## Docker Scope

The Docker web runtime may be responsible for:

- Building application container images
- Packaging frontend build output
- Packaging backend/runtime services
- Exposing HTTP or HTTPS entry points
- Connecting application services
- Connecting required data services
- Providing container-level runtime configuration
- Defining development or deployment compositions
- Providing health checks
- Defining persistent volumes where required
- Defining internal and external container networks
- Supporting reproducible local and deployment environments

The exact services included in the Docker runtime must be derived from:

- `00-META/context/stack.yml`
- The selected frontend stack
- The selected backend/runtime stack
- The selected databases
- The selected search engines
- The enabled local, remote and asset server targets
- Project specifications
- Architectural decisions

## Separation of Responsibilities

Docker must remain an integration and delivery boundary.

It must not absorb responsibilities owned by the application layers.

### Frontend Responsibility

Frontend source code belongs in:

```text
04-ENGINEERING/client/
```

Docker may build or serve generated frontend artifacts, but it must not duplicate frontend implementation code.

### Backend Responsibility

Backend and runtime source code belongs in:

```text
04-ENGINEERING/server/
```

Docker may package and execute backend services, but it must not duplicate backend implementation code.

### Data Responsibility

Database schemas, migrations and data contracts belong in the relevant data or backend sections.

Docker may instantiate development or deployment data-service containers, but it must not become the source of truth for application data models.

### Shell Responsibility

Docker-specific files belong in the web shell implementation area.

These files may include:

```text
Dockerfile
compose.yml
compose.override.yml
.dockerignore
container entry points
health-check scripts
runtime configuration
```

Their exact placement must follow the generated project structure and active specifications.

## Docker and Orchestration

Docker provides containerization and container execution.

Docker Compose may define a local or project-level multi-container composition when selected by the project.

Docker must not automatically be described as the complete production orchestration platform.

Advanced orchestration concerns require an explicit project decision.

These concerns include:

- Cluster scheduling
- High availability
- Automatic scaling
- Multi-node deployment
- Workload rescheduling
- Distributed service discovery

They may be handled by Kubernetes or another orchestration platform only when explicitly selected by the project.

Do not introduce Kubernetes or another orchestration platform unless it is explicitly selected or required by a specification.

## Mandatory Rules

- Treat Docker as the project web runtime shell.
- Keep frontend, backend, data and shell responsibilities separated.
- Use the selected frontend and backend technologies as the application implementation sources.
- Use explicit and reproducible image versions.
- Prefer official or project-approved base images.
- Use multi-stage builds when they reduce final image size or separate build and runtime dependencies.
- Keep runtime images minimal.
- Run application processes as non-root users whenever supported.
- Use `.dockerignore` to exclude unnecessary files and sensitive local artifacts.
- Keep environment-specific values outside container images.
- Use environment variables or mounted configuration for runtime configuration.
- Never bake credentials, tokens, private keys or environment secrets into images.
- Define health checks for long-running services when applicable.
- Define persistent volumes only for data that must survive container replacement.
- Keep container networks explicit when multiple services communicate.
- Use stable service names within project compositions.
- Keep host port exposure limited to services that require external access.
- Write container logs to standard output and standard error unless the project explicitly requires another strategy.
- Keep Docker configuration synchronized with the selected frontend, backend and data services.
- Validate image builds after Docker-related changes.
- Validate container startup and service connectivity after composition changes.
- Keep Docker documentation synchronized with executable configuration.

## Image Rules

- Pin base images to explicit supported versions.
- Prefer official or project-approved base images.
- Separate build dependencies from runtime dependencies.
- Do not copy the entire repository into an image when only selected artifacts are required.
- Order build steps to preserve useful build-cache layers.
- Remove package-manager caches and temporary build files from runtime images.
- Document required build arguments.
- Do not use build arguments for persistent secrets.
- Preserve architecture compatibility when multiple CPU architectures are targeted.

## Runtime Configuration Rules

- Runtime configuration must remain external to immutable images.
- Required environment variables must be documented.
- Missing mandatory configuration must cause an explicit startup failure.
- Default values must be safe for local development.
- Production-specific configuration must not be committed with real credentials.
- Container entry points must preserve operating-system signals.
- Long-running processes must support graceful shutdown.
- File permissions must be explicit for mounted directories and generated files.

## Service Composition Rules

When a composition file is used:

- Define only services required by the selected project profile.
- Keep service dependencies explicit.
- Use health conditions when startup ordering depends on service readiness.
- Do not confuse container creation order with application readiness.
- Use named volumes for durable project data when appropriate.
- Use internal networks for services that do not require host access.
- Keep local-development overrides separate from production deployment decisions.
- Do not duplicate application configuration unnecessarily across composition files.

## Security Rules

- Do not run privileged containers unless an explicit architectural decision requires it.
- Do not mount the Docker socket into application containers by default.
- Do not expose database or search-engine ports publicly unless explicitly required.
- Do not use host networking by default.
- Do not store secrets in Dockerfiles or committed composition files.
- Do not disable TLS verification to simplify connectivity.
- Do not grant broad filesystem access when a narrower mount is sufficient.
- Review third-party images before adding them to the project.
- Keep base images and runtime dependencies updateable.

## Forbidden

- Do not treat Docker as a frontend framework.
- Do not describe Docker as the owner of the user interface.
- Do not move frontend code into the Docker shell.
- Do not move backend business logic into Docker entry-point scripts.
- Do not duplicate frontend or backend implementation inside Docker-specific files.
- Do not treat container definitions as the source of truth for domain models.
- Do not introduce services absent from the selected project profile.
- Do not introduce Kubernetes or another orchestrator without an explicit decision.
- Do not use `latest` as an uncontrolled production image version.
- Do not commit credentials or secrets.
- Do not expose every service port to the host.
- Do not use privileged mode as a convenience.
- Do not mount the Docker socket without an explicit and documented requirement.
- Do not rely only on container startup order for service readiness.
- Do not claim that a containerized application is production-ready without the required validation and deployment decisions.

## Agent Instructions

Before generating or modifying Docker configuration:

1. Read this skill completely.
2. Read `00-META/context/stack.yml`.
3. Identify the selected frontend stack.
4. Identify the selected backend/runtime stack.
5. Identify the selected databases and search engines.
6. Identify enabled local, remote and asset server targets.
7. Inspect the existing Dockerfiles and composition files.
8. Preserve the separation between frontend, backend, data and shell responsibilities.
9. Generate only services required by the selected project profile.
10. Keep Docker focused on integration, execution, packaging and delivery.
11. Validate image builds.
12. Validate container startup.
13. Validate service health and connectivity.
14. Report any validation that could not be executed.

When explaining the architecture, use the following terminology:

```text
Docker Web Runtime Shell
```

Do not characterize Docker as:

```text
a frontend framework
a web UI framework
the application frontend
the application backend
the default production orchestrator
```

The authoritative interpretation is:

> Docker is the containerized web execution and delivery envelope surrounding the selected frontend, backend and data services.
