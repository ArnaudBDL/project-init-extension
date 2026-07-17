import {
    ProjectProfile
} from '../models/project-profile';

import {
    BACKEND_FRAMEWORKS,
    BACKEND_STACKS,
    getBackendFrameworkLabel,
    getBackendStackLabel
} from '../registries/backend.registry';

import {
    DATABASES,
    DataService,
    SEARCH_ENGINES
} from '../registries/data.registry';

import {
    FRONTEND_STACKS,
    FRONTEND_VARIANTS,
    getFrontendStackLabel,
    getFrontendVariantLabel
} from '../registries/frontend.registry';

import {
    DESKTOP_SHELLS,
    getShellLabel,
    MOBILE_SHELLS,
    Shell,
    WEB_SHELLS
} from '../registries/shell.registry';

import {
    TemplateContext
} from '../services/template.service';

export function createTemplateContext(
    profile: ProjectProfile
): TemplateContext {
    const hasFrontend =
        profile.frontendStack !== 'none';

    const hasFrontendVariant =
        profile.frontendVariant !== 'none';

    const hasBackendStack =
        profile.backendStack !== 'none';

    const hasBackendFramework =
        profile.backendFramework !== 'none';

    const hasServer =
        hasBackendStack ||
        profile.serverLocalEnabled ||
        profile.serverRemoteEnabled ||
        profile.serverAssetsEnabled;

    const hasDatabases =
        profile.databases.length > 0;

    const hasSearchEngines =
        profile.searchEngines.length > 0;

    const hasDesktop =
        profile.desktopShell !== 'none';

    const hasMobile =
        profile.mobileShell !== 'none';

    const hasWeb =
        profile.webShell !== 'none';

    const hasShell =
        hasDesktop ||
        hasMobile ||
        hasWeb;

    const frontendName = getFrontendStackLabel(
        profile.frontendStack
    );

    const frontendVariantName =
        getFrontendVariantLabel(
            profile.frontendStack,
            profile.frontendVariant
        );

    const backendName = getBackendStackLabel(
        profile.backendStack
    );

    const backendFrameworkName =
        getBackendFrameworkLabel(
            profile.backendStack,
            profile.backendFramework
        );

    const databaseNames = createLabelList(
        profile.databases,
        DATABASES
    );

    const searchEngineNames = createLabelList(
        profile.searchEngines,
        SEARCH_ENGINES
    );

    const desktopShellName = getShellLabel(
        profile.desktopShell,
        DESKTOP_SHELLS
    );

    const mobileShellName = getShellLabel(
        profile.mobileShell,
        MOBILE_SHELLS
    );

    const webShellName = getShellLabel(
        profile.webShell,
        WEB_SHELLS
    );

    return {
        PROJECT_NAME:
            profile.projectName,

        PROJECT_SLUG:
            profile.projectSlug,

        PROJECT_NAME_YAML:
            yamlEscape(profile.projectName),

        PROJECT_SLUG_YAML:
            yamlEscape(profile.projectSlug),

        PROJECT_HAS_FRONTEND:
            booleanValue(hasFrontend),

        PROJECT_HAS_FRONTEND_VARIANT:
            booleanValue(hasFrontendVariant),

        PROJECT_HAS_BACKEND_STACK:
            booleanValue(hasBackendStack),

        PROJECT_HAS_BACKEND_FRAMEWORK:
            booleanValue(hasBackendFramework),
        
        PROJECT_HAS_RUNTIME_TARGETS:
            booleanValue(
                profile.serverLocalEnabled ||
                profile.serverRemoteEnabled
            ),

        PROJECT_HAS_DATA_SERVICES:
            booleanValue(
                profile.databases.length > 0 ||
                profile.searchEngines.length > 0
            ),

        PROJECT_HAS_SERVER:
            booleanValue(hasServer),

        PROJECT_HAS_DATABASES:
            booleanValue(hasDatabases),

        PROJECT_HAS_SEARCH_ENGINES:
            booleanValue(hasSearchEngines),

        PROJECT_HAS_DESKTOP:
            booleanValue(hasDesktop),

        PROJECT_HAS_MOBILE:
            booleanValue(hasMobile),

        PROJECT_HAS_WEB:
            booleanValue(hasWeb),

        PROJECT_HAS_SHELL:
            booleanValue(hasShell),

        PROJECT_HAS_LEGACY:
            booleanValue(profile.legacyEnabled),

        FRONTEND_STACK:
            profile.frontendStack,

        FRONTEND_VARIANT:
            profile.frontendVariant,

        PROJECT_FRONTEND_NAME:
            frontendName,

        PROJECT_FRONTEND_VARIANT_NAME:
            frontendVariantName,

        BACKEND_STACK:
            profile.backendStack,

        BACKEND_FRAMEWORK:
            profile.backendFramework,

        PROJECT_BACKEND_NAME:
            backendName,

        PROJECT_BACKEND_FRAMEWORK_NAME:
            backendFrameworkName,

        ENABLED_SERVER_LOCAL:
            booleanValue(
                profile.serverLocalEnabled
            ),

        ENABLED_SERVER_REMOTE:
            booleanValue(
                profile.serverRemoteEnabled
            ),

        ENABLED_SERVER_ASSETS:
            booleanValue(
                profile.serverAssetsEnabled
            ),

        PROJECT_DATABASE_NAMES:
            databaseNames,

        PROJECT_SEARCH_ENGINE_NAMES:
            searchEngineNames,

        DATABASE_BULLETS:
            createBulletList(
                profile.databases,
                DATABASES
            ),

        SEARCH_ENGINE_BULLETS:
            createBulletList(
                profile.searchEngines,
                SEARCH_ENGINES
            ),

        DATABASES_YAML:
            createYamlCollection(
                'databases',
                profile.databases,
                DATABASES
            ),

        SEARCH_ENGINES_YAML:
            createYamlCollection(
                'searchEngines',
                profile.searchEngines,
                SEARCH_ENGINES
            ),

        SHELL_DESKTOP:
            profile.desktopShell,

        SHELL_MOBILE:
            profile.mobileShell,

        SHELL_WEB:
            profile.webShell,

        PROJECT_DESKTOP_SHELL_NAME:
            desktopShellName,

        PROJECT_MOBILE_SHELL_NAME:
            mobileShellName,

        PROJECT_WEB_SHELL_NAME:
            webShellName,

        LEGACY_ENABLED:
            booleanValue(profile.legacyEnabled),

        ACTIVE_SKILLS:
            createActiveSkills(profile),

        GENERATED_SKILL_DIRECTORIES:
            createSkillDirectoryList(profile),

        ENGINEERING_TECHNICAL_PROFILE:
            createEngineeringTechnicalProfile(
                profile
            ),

        ENGINEERING_RUNTIME_TARGETS:
            createEngineeringRuntimeTargets(
                profile
            ),

        SERVER_GENERATED_STRUCTURE:
            createServerGeneratedStructure(
                profile
            ),

        ENGINEERING_PROJECT_LAYOUT:
            createEngineeringProjectLayout(
                profile
            ),

        ENGINEERING_PREREQUISITES:
            createEngineeringPrerequisites(
                profile
            )
    };
}

export function getSelectedSkillKeys(
    profile: ProjectProfile
): string[] {
    const selectedSkills = [
        profile.frontendStack,
        profile.frontendVariant,
        profile.backendStack,
        profile.backendFramework,
        profile.desktopShell,
        profile.mobileShell,
        profile.webShell,
        ...profile.databases,
        ...profile.searchEngines
    ];

    return [
        ...new Set(
            selectedSkills.filter(
                skill =>
                    skill !== '' &&
                    skill !== 'none'
            )
        )
    ];
}

export function getSkillLabel(
    profile: ProjectProfile,
    skillKey: string
): string {
    if (skillKey === profile.frontendStack) {
        return getFrontendStackLabel(
            skillKey
        );
    }

    if (skillKey === profile.frontendVariant) {
        return getFrontendVariantLabel(
            profile.frontendStack,
            skillKey
        );
    }

    if (skillKey === profile.backendStack) {
        return getBackendStackLabel(
            skillKey
        );
    }

    if (skillKey === profile.backendFramework) {
        return getBackendFrameworkLabel(
            profile.backendStack,
            skillKey
        );
    }

    const frontendStackLabel =
        findLabel(
            skillKey,
            FRONTEND_STACKS
        );

    if (frontendStackLabel) {
        return frontendStackLabel;
    }

    for (
        const variants
        of Object.values(FRONTEND_VARIANTS)
    ) {
        const label = findLabel(
            skillKey,
            variants
        );

        if (label) {
            return label;
        }
    }

    const backendStackLabel =
        findLabel(
            skillKey,
            BACKEND_STACKS
        );

    if (backendStackLabel) {
        return backendStackLabel;
    }

    for (
        const frameworks
        of Object.values(BACKEND_FRAMEWORKS)
    ) {
        const label = findLabel(
            skillKey,
            frameworks
        );

        if (label) {
            return label;
        }
    }

    const desktopShellLabel =
        findShellLabel(
            skillKey,
            DESKTOP_SHELLS
        );

    if (desktopShellLabel) {
        return desktopShellLabel;
    }

    const mobileShellLabel =
        findShellLabel(
            skillKey,
            MOBILE_SHELLS
        );

    if (mobileShellLabel) {
        return mobileShellLabel;
    }

    const webShellLabel =
        findShellLabel(
            skillKey,
            WEB_SHELLS
        );

    if (webShellLabel) {
        return webShellLabel;
    }

    const databaseLabel =
        findLabel(
            skillKey,
            DATABASES
        );

    if (databaseLabel) {
        return databaseLabel;
    }

    const searchEngineLabel =
        findLabel(
            skillKey,
            SEARCH_ENGINES
        );

    if (searchEngineLabel) {
        return searchEngineLabel;
    }

    return skillKey;
}

function booleanValue(
    value: boolean
): string {
    return value ? 'true' : 'false';
}

function createLabelList(
    selectedKeys: readonly string[],
    registry: readonly DataService[]
): string {
    if (selectedKeys.length === 0) {
        return 'None';
    }

    return selectedKeys
        .map(
            key => registry.find(
                item => item.key === key
            )?.label ?? key
        )
        .join(', ');
}

function createBulletList(
    selectedKeys: readonly string[],
    registry: readonly DataService[]
): string {
    if (selectedKeys.length === 0) {
        return 'None.';
    }

    return selectedKeys
        .map(
            key => {
                const label = registry.find(
                    item => item.key === key
                )?.label ?? key;

                return `- ${label}`;
            }
        )
        .join('\n');
}

function createYamlCollection(
    propertyName: string,
    selectedKeys: readonly string[],
    registry: readonly DataService[]
): string {
    if (selectedKeys.length === 0) {
        return `  ${propertyName}: []`;
    }

    const lines: string[] = [
        `  ${propertyName}:`
    ];

    for (const key of selectedKeys) {
        const label = registry.find(
            item => item.key === key
        )?.label ?? key;

        lines.push(
            `    - key: "${yamlEscape(key)}"`,
            `      name: "${yamlEscape(label)}"`
        );
    }

    return lines.join('\n');
}

function createActiveSkills(
    profile: ProjectProfile
): string {
    const lines: string[] = [];

    appendActiveSkill(
        lines,
        profile.frontendStack,
        getFrontendStackLabel(
            profile.frontendStack
        ),
        'frontend application technology'
    );

    appendActiveSkill(
        lines,
        profile.frontendVariant,
        getFrontendVariantLabel(
            profile.frontendStack,
            profile.frontendVariant
        ),
        'frontend application variant'
    );

    appendActiveSkill(
        lines,
        profile.backendStack,
        getBackendStackLabel(
            profile.backendStack
        ),
        'backend/runtime implementation technology'
    );

    appendActiveSkill(
        lines,
        profile.backendFramework,
        getBackendFrameworkLabel(
            profile.backendStack,
            profile.backendFramework
        ),
        'backend application framework'
    );

    appendActiveSkill(
        lines,
        profile.desktopShell,
        getShellLabel(
            profile.desktopShell,
            DESKTOP_SHELLS
        ),
        'desktop shell implementation technology'
    );

    appendActiveSkill(
        lines,
        profile.mobileShell,
        getShellLabel(
            profile.mobileShell,
            MOBILE_SHELLS
        ),
        'mobile shell implementation technology'
    );

    appendActiveSkill(
        lines,
        profile.webShell,
        getShellLabel(
            profile.webShell,
            WEB_SHELLS
        ),
        'web shell implementation technology'
    );

    for (const database of profile.databases) {
        lines.push(
            `- ${getSkillLabel(
                profile,
                database
            )}: database or data store.`
        );
    }

    for (
        const searchEngine
        of profile.searchEngines
    ) {
        lines.push(
            `- ${getSkillLabel(
                profile,
                searchEngine
            )}: search engine.`
        );
    }

    lines.push(
        '- Kanban: project task management convention.',
        '- Specifications: project specification format and workflow.'
    );

    return lines.join('\n');
}

function appendActiveSkill(
    lines: string[],
    key: string,
    label: string,
    description: string
): void {
    if (!key || key === 'none') {
        return;
    }

    lines.push(
        `- ${label}: ${description}.`
    );
}

function createSkillDirectoryList(
    profile: ProjectProfile
): string {
    const directories = getSelectedSkillKeys(
        profile
    ).map(
        skill => `- ${skill}/`
    );

    directories.push(
        '- kanban/',
        '- specs/'
    );

    return directories.join('\n');
}

function createEngineeringTechnicalProfile(
    profile: ProjectProfile
): string {
    const lines: string[] = [];

    if (profile.frontendStack !== 'none') {
        lines.push(
            `- Frontend: ${getFrontendStackLabel(
                profile.frontendStack
            )}`
        );
    }

    if (profile.frontendVariant !== 'none') {
        lines.push(
            `- Frontend Variant: ${getFrontendVariantLabel(
                profile.frontendStack,
                profile.frontendVariant
            )}`
        );
    }

    if (profile.backendStack !== 'none') {
        lines.push(
            `- Backend: ${getBackendStackLabel(
                profile.backendStack
            )}`
        );
    }

    if (profile.backendFramework !== 'none') {
        lines.push(
            `- Backend Framework: ${getBackendFrameworkLabel(
                profile.backendStack,
                profile.backendFramework
            )}`
        );
    }

    if (profile.databases.length > 0) {
        lines.push(
            `- Databases: ${createLabelList(
                profile.databases,
                DATABASES
            )}`
        );
    }

    if (profile.searchEngines.length > 0) {
        lines.push(
            `- Search Engines: ${createLabelList(
                profile.searchEngines,
                SEARCH_ENGINES
            )}`
        );
    }

    if (profile.desktopShell !== 'none') {
        lines.push(
            `- Desktop Shell: ${getShellLabel(
                profile.desktopShell,
                DESKTOP_SHELLS
            )}`
        );
    }

    if (profile.mobileShell !== 'none') {
        lines.push(
            `- Mobile Shell: ${getShellLabel(
                profile.mobileShell,
                MOBILE_SHELLS
            )}`
        );
    }

    if (profile.webShell !== 'none') {
        lines.push(
            `- Web Shell: ${getShellLabel(
                profile.webShell,
                WEB_SHELLS
            )}`
        );
    }

    return lines.length > 0
        ? lines.join('\n')
        : 'None.';
}

function createEngineeringRuntimeTargets(
    profile: ProjectProfile
): string {
    const lines: string[] = [];

    if (profile.serverLocalEnabled) {
        lines.push(
            '- Local Runtime: true'
        );
    }

    if (profile.serverRemoteEnabled) {
        lines.push(
            '- Remote Runtime: true'
        );
    }

    if (profile.serverAssetsEnabled) {
        lines.push(
            '- Asset Server: true'
        );
    }

    return lines.length > 0
        ? lines.join('\n')
        : 'None.';
}

function createServerGeneratedStructure(
    profile: ProjectProfile
): string {
    const lines: string[] = [];

    if (profile.backendStack !== 'none') {
        lines.push(
            '- modules: reusable backend/runtime modules'
        );
    }

    if (profile.serverLocalEnabled) {
        lines.push(
            '- local: local runtime entry point'
        );
    }

    if (profile.serverRemoteEnabled) {
        lines.push(
            '- remote: remote runtime entry point'
        );
    }

    if (profile.serverAssetsEnabled) {
        lines.push(
            '- assets: shared asset delivery'
        );
    }

    return lines.length > 0
        ? lines.join('\n')
        : 'None.';
}

function createEngineeringProjectLayout(
    profile: ProjectProfile
): string {
    const lines: string[] = [];

    if (profile.frontendStack !== 'none') {
        lines.push(
            '- client: frontend application'
        );
    }

    const hasServer =
        profile.backendStack !== 'none' ||
        profile.serverLocalEnabled ||
        profile.serverRemoteEnabled ||
        profile.serverAssetsEnabled;

    if (hasServer) {
        lines.push(
            '- server: backend/runtime and delivery implementation'
        );
    }

    const hasShell =
        profile.desktopShell !== 'none' ||
        profile.mobileShell !== 'none' ||
        profile.webShell !== 'none';

    if (hasShell) {
        lines.push(
            '- shell: platform-specific application shells'
        );
    }

    return lines.length > 0
        ? lines.join('\n')
        : 'No implementation section selected.';
}

function createEngineeringPrerequisites(
    profile: ProjectProfile
): string {
    const lines: string[] = [];

    if (profile.frontendStack !== 'none') {
        lines.push(
            `- Install the toolchain required by ${getFrontendStackLabel(
                profile.frontendStack
            )}.`
        );
    }

    if (profile.backendStack !== 'none') {
        lines.push(
            `- Install the backend/runtime toolchain required by ${getBackendStackLabel(
                profile.backendStack
            )}.`
        );
    }

    if (profile.desktopShell !== 'none') {
        lines.push(
            `- Install the desktop shell toolchain required by ${getShellLabel(
                profile.desktopShell,
                DESKTOP_SHELLS
            )}.`
        );
    }

    if (profile.mobileShell !== 'none') {
        lines.push(
            `- Install the mobile shell toolchain required by ${getShellLabel(
                profile.mobileShell,
                MOBILE_SHELLS
            )}.`
        );
    }

    if (profile.webShell !== 'none') {
        lines.push(
            `- Install the web shell or orchestration tooling required by ${getShellLabel(
                profile.webShell,
                WEB_SHELLS
            )}.`
        );
    }

    if (profile.serverAssetsEnabled) {
        lines.push(
            '- Define shared asset publishing requirements for this project.'
        );
    }

    return lines.length > 0
        ? lines.join('\n')
        : 'No specific toolchain selected.';
}

function findLabel(
    key: string,
    registry: readonly {
        key: string;
        label: string;
    }[]
): string | undefined {
    return registry.find(
        item => item.key === key
    )?.label;
}

function findShellLabel(
    key: string,
    registry: readonly Shell[]
): string | undefined {
    return registry.find(
        item => item.key === key
    )?.label;
}

function yamlEscape(
    value: string
): string {
    return value
        .replace(/\\/g, '\\\\')
        .replace(/"/g, '\\"');
}
