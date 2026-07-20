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
        backofficeEnabled: false,

        backendStack: 'none',
        backendFramework: 'none',

        serverLocalEnabled: false,

        remoteServerArchitecture: 'none',
        remoteServiceDomains: [],

        serverAssetsEnabled: false,

        databases: [],
        searchEngines: [],

        desktopShell: 'none',
        mobileShell: 'none',
        webShell: 'none',

        legacyEnabled: false
    };
}