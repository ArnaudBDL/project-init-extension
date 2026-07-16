import {
    ProjectProfile
} from '../models/project-profile';

export function createProjectProfile(
    workspaceRoot: string
): ProjectProfile {
    return {
        workspaceRoot,

        projectName: '',
        projectSlug: '',

        frontendStack: 'none',
        frontendVariant: 'none',

        backendStack: 'none',
        backendFramework: 'none',

        serverLocalEnabled: false,
        serverRemoteEnabled: false,
        serverAssetsEnabled: false,

        databases: [],
        searchEngines: [],

        desktopShell: 'none',
        mobileShell: 'none',
        webShell: 'none',

        legacyEnabled: false
    };
}