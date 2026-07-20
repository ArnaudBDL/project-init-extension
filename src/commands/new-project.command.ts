import * as vscode from 'vscode';

import {
    ProjectGenerator
} from '../generators/project.generator';

import {
    askBackendFramework
} from '../interview/backend-framework.step';

import {
    askBackendStack
} from '../interview/backend-stack.step';

import {
    askClientTargets
} from '../interview/client-targets.step';

import {
    askDatabases
} from '../interview/databases.step';

import {
    askFrontendStack
} from '../interview/frontend-stack.step';

import {
    askFrontendVariant
} from '../interview/frontend-variant.step';

import {
    askLegacyProject
} from '../interview/legacy-project.step';

import {
    askProjectName
} from '../interview/project-name.step';

import {
    askSearchEngines
} from '../interview/search-engines.step';

import {
    askServerTargets
} from '../interview/server-targets.step';

import {
    askShellTargets
} from '../interview/shell-targets.step';

import {
    showInterviewSummary
} from '../interview/summary.step';

import {
    createProjectProfile
} from '../services/project-profile.service';

import {
    getWorkspaceName,
    getWorkspaceRoot
} from '../services/workspace.service';

export async function newProjectCommand(
    extensionUri: vscode.Uri
): Promise<void> {
    let workspaceRoot: string;
    let workspaceName: string;

    try {
        workspaceRoot = getWorkspaceRoot();
        workspaceName = getWorkspaceName();
    } catch {
        await vscode.window.showErrorMessage(
            'Open a workspace folder before starting Project Builder.'
        );

        return;
    }

    const profile = createProjectProfile(
        workspaceRoot
    );

    const identity = await askProjectName(
        workspaceName
    );

    if (identity === undefined) {
        return;
    }

    profile.projectName = identity.name;
    profile.projectSlug = identity.slug;

    const frontendStack = await askFrontendStack();

    if (frontendStack === undefined) {
        return;
    }

    profile.frontendStack = frontendStack;

    const frontendVariant =
        await askFrontendVariant(
            profile.frontendStack
        );

    if (frontendVariant === undefined) {
        return;
    }

    profile.frontendVariant = frontendVariant;

    const clientTargetsCompleted =
        await askClientTargets(profile);

    if (!clientTargetsCompleted) {
        return;
    }

    const backendStack = await askBackendStack();

    if (backendStack === undefined) {
        return;
    }

    profile.backendStack = backendStack;

    const backendFramework =
        await askBackendFramework(
            profile.backendStack
        );

    if (backendFramework === undefined) {
        return;
    }

    profile.backendFramework =
        backendFramework;

    const serverTargetsCompleted =
        await askServerTargets(profile);

    if (!serverTargetsCompleted) {
        return;
    }

    const databases = await askDatabases();

    if (databases === undefined) {
        return;
    }

    profile.databases = databases;

    const searchEngines =
        await askSearchEngines();

    if (searchEngines === undefined) {
        return;
    }

    profile.searchEngines = searchEngines;

    const shellTargetsCompleted =
        await askShellTargets(profile);

    if (!shellTargetsCompleted) {
        return;
    }

    const legacyEnabled =
        await askLegacyProject();

    if (legacyEnabled === undefined) {
        return;
    }

    profile.legacyEnabled = legacyEnabled;

    const generationConfirmed =
        await showInterviewSummary(
            profile
        );

    if (!generationConfirmed) {
        await vscode.window.showInformationMessage(
            'Project generation cancelled.'
        );

        return;
    }

    const generator = new ProjectGenerator(
        extensionUri
    );

    try {
        const report =
            await vscode.window.withProgress(
                {
                    location:
                        vscode.ProgressLocation.Notification,

                    title:
                        `Generating ${profile.projectName}`,

                    cancellable: false
                },

                async progress => {
                    progress.report({
                        message:
                            'Writing project documents...'
                    });

                    return generator.generate(
                        profile
                    );
                }
            );

        await vscode.window.showInformationMessage(
            [
                `Project scaffold generated for ${profile.projectName}.`,
                `${report.createdFiles.length} file(s) created.`,
                `${report.skippedFiles.length} existing file(s) preserved.`
            ].join(' ')
        );
    } catch (error: unknown) {
        const message =
            error instanceof Error
                ? error.message
                : String(error);

        await vscode.window.showErrorMessage(
            `Project generation failed: ${message}`
        );
    }
}