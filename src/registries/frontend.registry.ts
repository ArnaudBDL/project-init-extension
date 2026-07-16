export interface FrontendStack {
    key: string;
    label: string;
}

export interface FrontendVariant {
    key: string;
    label: string;
}

export const FRONTEND_STACKS: readonly FrontendStack[] = [
    {
        key: 'angular',
        label: 'Angular'
    },
    {
        key: 'react',
        label: 'React'
    },
    {
        key: 'vue',
        label: 'Vue'
    },
    {
        key: 'svelte',
        label: 'Svelte'
    },
    {
        key: 'solid',
        label: 'SolidJS'
    },
    {
        key: 'preact',
        label: 'Preact'
    },
    {
        key: 'astro',
        label: 'Astro'
    },
    {
        key: 'qwik',
        label: 'Qwik'
    },
    {
        key: 'html-js-css',
        label: 'HTML/CSS/JS'
    }
];

export const FRONTEND_VARIANTS: Readonly<
    Record<string, readonly FrontendVariant[]>
> = {
    angular: [
        {
            key: 'analog',
            label: 'Analog'
        }
    ],

    react: [
        {
            key: 'nextjs',
            label: 'Next.js'
        },
        {
            key: 'react-router',
            label: 'React Router'
        }
    ],

    vue: [
        {
            key: 'nuxt',
            label: 'Nuxt'
        }
    ],

    svelte: [
        {
            key: 'sveltekit',
            label: 'SvelteKit'
        }
    ],

    solid: [
        {
            key: 'solidstart',
            label: 'SolidStart'
        }
    ],

    preact: [
        {
            key: 'fresh',
            label: 'Fresh'
        }
    ],

    astro: [],

    qwik: [
        {
            key: 'qwik-city',
            label: 'Qwik City'
        }
    ],

    'html-js-css': []
};

export function getFrontendStackLabel(
    key: string
): string {
    if (key === 'none') {
        return 'None';
    }

    return FRONTEND_STACKS.find(
        stack => stack.key === key
    )?.label ?? key;
}

export function getFrontendVariantLabel(
    stack: string,
    key: string
): string {
    if (key === 'none') {
        return 'None';
    }

    return FRONTEND_VARIANTS[stack]?.find(
        variant => variant.key === key
    )?.label ?? key;
}
