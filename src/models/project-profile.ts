export interface ProjectProfile {
    workspaceRoot: string;

    projectName: string;
    projectSlug: string;

    frontendStack: string;
    frontendVariant: string;

    backendStack: string;
    backendFramework: string;

    serverLocalEnabled: boolean;
    serverRemoteEnabled: boolean;
    serverAssetsEnabled: boolean;

    databases: string[];
    searchEngines: string[];

    desktopShell: string;
    mobileShell: string;
    webShell: string;

    legacyEnabled: boolean;
}