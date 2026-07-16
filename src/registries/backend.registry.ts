export interface BackendStack {
    key: string;
    label: string;
}

export interface BackendFramework {
    key: string;
    label: string;
}

export const BACKEND_STACKS: readonly BackendStack[] = [
    {
        key: 'go',
        label: 'Go'
    },
    {
        key: 'node',
        label: 'Node.js'
    },
    {
        key: 'php',
        label: 'PHP'
    },
    {
        key: 'python',
        label: 'Python'
    },
    {
        key: 'dotnet',
        label: '.NET'
    },
    {
        key: 'java',
        label: 'Java'
    },
    {
        key: 'kotlin',
        label: 'Kotlin'
    },
    {
        key: 'rust',
        label: 'Rust'
    },
    {
        key: 'ruby',
        label: 'Ruby'
    }
];

export const BACKEND_FRAMEWORKS: Readonly<
    Record<string, readonly BackendFramework[]>
> = {
    go: [
        {
            key: 'stdlib',
            label: 'Standard Library'
        },
        {
            key: 'gin',
            label: 'Gin'
        },
        {
            key: 'fiber',
            label: 'Fiber'
        },
        {
            key: 'echo',
            label: 'Echo'
        }
    ],

    node: [
        {
            key: 'nestjs',
            label: 'NestJS'
        },
        {
            key: 'express',
            label: 'Express'
        },
        {
            key: 'fastify',
            label: 'Fastify'
        },
        {
            key: 'hono',
            label: 'Hono'
        }
    ],

    php: [
        {
            key: 'symfony',
            label: 'Symfony'
        },
        {
            key: 'laravel',
            label: 'Laravel'
        },
        {
            key: 'api-platform',
            label: 'API Platform'
        }
    ],

    python: [
        {
            key: 'fastapi',
            label: 'FastAPI'
        },
        {
            key: 'django',
            label: 'Django'
        },
        {
            key: 'flask',
            label: 'Flask'
        }
    ],

    dotnet: [
        {
            key: 'aspnet-core',
            label: 'ASP.NET Core'
        }
    ],

    java: [
        {
            key: 'spring-boot',
            label: 'Spring Boot'
        },
        {
            key: 'quarkus',
            label: 'Quarkus'
        },
        {
            key: 'micronaut',
            label: 'Micronaut'
        },
        {
            key: 'jakarta-ee',
            label: 'Jakarta EE'
        }
    ],

    kotlin: [
        {
            key: 'ktor',
            label: 'Ktor'
        },
        {
            key: 'spring-boot',
            label: 'Spring Boot'
        }
    ],

    rust: [
        {
            key: 'axum',
            label: 'Axum'
        },
        {
            key: 'actix-web',
            label: 'Actix Web'
        },
        {
            key: 'rocket',
            label: 'Rocket'
        }
    ],

    ruby: [
        {
            key: 'rails',
            label: 'Ruby on Rails'
        },
        {
            key: 'sinatra',
            label: 'Sinatra'
        }
    ]
};

export function getBackendStackLabel(
    key: string
): string {
    if (key === 'none') {
        return 'None';
    }

    return BACKEND_STACKS.find(
        stack => stack.key === key
    )?.label ?? key;
}

export function getBackendFrameworkLabel(
    stack: string,
    key: string
): string {
    if (key === 'none') {
        return 'None';
    }

    return BACKEND_FRAMEWORKS[stack]?.find(
        framework => framework.key === key
    )?.label ?? key;
}