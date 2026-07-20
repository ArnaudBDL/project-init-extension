export type RemoteServerArchitecture =
    | 'none'
    | 'monolith'
    | 'microservices';

export interface ProjectProfile {
    workspaceRoot: string;

    projectName: string;
    projectSlug: string;

    frontendStack: string;
    frontendVariant: string;
    backofficeEnabled: boolean;

    backendStack: string;
    backendFramework: string;

    serverLocalEnabled: boolean;

    remoteServerArchitecture: RemoteServerArchitecture;
    remoteServiceDomains: string[];

    serverAssetsEnabled: boolean;

    databases: string[];
    searchEngines: string[];

    desktopShell: string;
    mobileShell: string;
    webShell: string;

    legacyEnabled: boolean;
}