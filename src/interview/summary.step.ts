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
        'FRONTEND',
        `Stack: ${getFrontendStackLabel(profile.frontendStack)}`,
        `Variant: ${getFrontendVariantLabel(
            profile.frontendStack,
            profile.frontendVariant
        )}`,
        '',
        'BACKEND',
        `Stack: ${getBackendStackLabel(profile.backendStack)}`,
        `Framework: ${getBackendFrameworkLabel(
            profile.backendStack,
            profile.backendFramework
        )}`,
        '',
        'APP SERVERS',
        `Local server: ${yesNo(profile.serverLocalEnabled)}`,
        `Remote server: ${yesNo(profile.serverRemoteEnabled)}`,
        `Asset server: ${yesNo(profile.serverAssetsEnabled)}`,
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
        'APP SHELLS',
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
        `Legacy migration: ${yesNo(profile.legacyEnabled)}`,
        '',
        `Workspace: ${profile.workspaceRoot}`
    ].join('\n');

    const selectedAction = await vscode.window.showInformationMessage(
        summary,
        {
            modal: true
        },
        'Generate',
        'Cancel'
    );

    return selectedAction === 'Generate';
}

function yesNo(value: boolean): string {
    return value ? 'Yes' : 'No';
}