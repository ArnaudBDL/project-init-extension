import * as vscode from 'vscode';

import {
    ProjectProfile
} from '../models/project-profile';

import {
    getBackendFrameworkLabel,
    getBackendStackLabel
} from '../registries/backend.registry';

import {
    DATABASES,
    getDataServiceLabels,
    SEARCH_ENGINES
} from '../registries/data.registry';

import {
    getFrontendStackLabel,
    getFrontendVariantLabel
} from '../registries/frontend.registry';

import {
    getRemoteServerArchitectureLabel
} from '../registries/server-architecture.registry';

import {
    DESKTOP_SHELLS,
    getShellLabel,
    MOBILE_SHELLS,
    WEB_SHELLS
} from '../registries/shell.registry';

export async function showInterviewSummary(
    profile: ProjectProfile
): Promise<boolean> {
    const summary = [
        'PROJECT',
        `Name: ${profile.projectName}`,
        `Slug: ${profile.projectSlug}`,
        '',
        'CLIENT',
        `Frontoffice: ${yesNo(
            profile.frontendStack !== 'none'
        )}`,
        `Backoffice: ${yesNo(
            profile.backofficeEnabled
        )}`,
        `Frontend stack: ${getFrontendStackLabel(
            profile.frontendStack
        )}`,
        `Frontend variant: ${getFrontendVariantLabel(
            profile.frontendStack,
            profile.frontendVariant
        )}`,
        '',
        'SERVER',
        `Backend: ${getBackendStackLabel(
            profile.backendStack
        )}`,
        `Backend framework: ${getBackendFrameworkLabel(
            profile.backendStack,
            profile.backendFramework
        )}`,
        `Local server: ${yesNo(
            profile.serverLocalEnabled
        )}`,
        `Remote architecture: ${getRemoteServerArchitectureLabel(
            profile.remoteServerArchitecture
        )}`,
        `Remote services: ${getRemoteServicesSummary(
            profile
        )}`,
        `Remote asset server: ${yesNo(
            profile.serverAssetsEnabled
        )}`,
        '',
        'DATA',
        `Databases: ${getDataServiceLabels(
            profile.databases,
            DATABASES
        )}`,
        `Search engines: ${getDataServiceLabels(
            profile.searchEngines,
            SEARCH_ENGINES
        )}`,
        '',
        'SHELLS',
        `Desktop: ${getShellLabel(
            profile.desktopShell,
            DESKTOP_SHELLS
        )}`,
        `Mobile: ${getShellLabel(
            profile.mobileShell,
            MOBILE_SHELLS
        )}`,
        `Web: ${getShellLabel(
            profile.webShell,
            WEB_SHELLS
        )}`,
        '',
        'LEGACY',
        `Legacy migration: ${yesNo(
            profile.legacyEnabled
        )}`,
        '',
        `Workspace: ${profile.workspaceRoot}`
    ].join('\n');

    const selectedAction =
        await vscode.window.showInformationMessage(
            summary,
            {
                modal: true
            },
            'Generate',
            'Cancel'
        );

    return selectedAction === 'Generate';
}

function getRemoteServicesSummary(
    profile: ProjectProfile
): string {
    if (
        profile.remoteServerArchitecture !==
        'microservices'
    ) {
        return 'None';
    }

    if (
        profile.remoteServiceDomains.length === 0
    ) {
        return 'None';
    }

    return profile.remoteServiceDomains.join(
        ', '
    );
}

function yesNo(
    value: boolean
): string {
    return value ? 'Yes' : 'No';
}