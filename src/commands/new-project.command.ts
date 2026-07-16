import * as path from 'path';
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
    ProjectProfile
} from '../models/project-profile';

import {
    loadProjectProfile
} from '../services/project-profile-loader.service';

import {
    createProjectProfile
} from '../services/project-profile.service';

import {
    getExistingStackFile
} from '../services/scaffold-detection.service';

import {
    getWorkspaceName,
    getWorkspaceRoot
} from '../services/workspace.service';

const OPEN_PROJECT_START_PROMPT =
    'Open Project Start Prompt';

const OPEN_GENERATED_README =
    'Open Generated README';

const COMPLETE_EXISTING_SCAFFOLD =
    'Complete Existing Scaffold';

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

    const stackFile = getExistingStackFile(
        workspaceRoot
    );

    if (stackFile !== undefined) {
        await runExistingScaffoldCompletion(
            extensionUri,
            workspaceRoot,
            stackFile
        );

        return;
    }

    await runNewProjectGeneration(
        extensionUri,
        workspaceRoot,
        workspaceName
    );
}

async function runExistingScaffoldCompletion(
    extensionUri: vscode.Uri,
    workspaceRoot: string,
    stackFile: string
): Promise<void> {
    let profile: ProjectProfile;

    try {
        profile = loadProjectProfile(
            workspaceRoot,
            stackFile
        );
    } catch (error: unknown) {
        const message =
            error instanceof Error
                ? error.message
                : String(error);

        await vscode.window.showErrorMessage(
            `Existing scaffold profile could not be loaded: ${message}`
        );

        return;
    }

    const action =
        await vscode.window.showInformationMessage(
            [
                `An existing scaffold was detected for ${profile.projectName}.`,
                'Project Builder will use 00-META/context/stack.yml',
                'and generate only missing files.'
            ].join(' '),
            {
                modal: true
            },
            COMPLETE_EXISTING_SCAFFOLD
        );

    if (
        action !== COMPLETE_EXISTING_SCAFFOLD
    ) {
        await vscode.window.showInformationMessage(
            'Scaffold completion cancelled.'
        );

        return;
    }

    await generateProject(
        extensionUri,
        workspaceRoot,
        profile,
        'Completing'
    );
}

async function runNewProjectGeneration(
    extensionUri: vscode.Uri,
    workspaceRoot: string,
    workspaceName: string
): Promise<void> {
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

    const frontendStack =
        await askFrontendStack();

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

    profile.frontendVariant =
        frontendVariant;

    const backendStack =
        await askBackendStack();

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
        await askServerTargets(
            profile
        );

    if (!serverTargetsCompleted) {
        return;
    }

    const databases =
        await askDatabases();

    if (databases === undefined) {
        return;
    }

    profile.databases = databases;

    const searchEngines =
        await askSearchEngines();

    if (searchEngines === undefined) {
        return;
    }

    profile.searchEngines =
        searchEngines;

    const shellTargetsCompleted =
        await askShellTargets(
            profile
        );

    if (!shellTargetsCompleted) {
        return;
    }

    const legacyEnabled =
        await askLegacyProject();

    if (legacyEnabled === undefined) {
        return;
    }

    profile.legacyEnabled =
        legacyEnabled;

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

    await generateProject(
        extensionUri,
        workspaceRoot,
        profile,
        'Generating'
    );
}

async function generateProject(
    extensionUri: vscode.Uri,
    workspaceRoot: string,
    profile: ProjectProfile,
    progressTitle: string
): Promise<void> {
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
                        `${progressTitle} ${profile.projectName}`,

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

        const action =
            await vscode.window.showInformationMessage(
                [
                    `Project scaffold generated for ${profile.projectName}.`,
                    `${report.createdFiles.length} file(s) created.`,
                    `${report.skippedFiles.length} existing file(s) preserved.`
                ].join(' '),
                OPEN_PROJECT_START_PROMPT,
                OPEN_GENERATED_README
            );

        if (
            action === OPEN_PROJECT_START_PROMPT
        ) {
            await openProjectStartPrompt(
                workspaceRoot
            );

            return;
        }

        if (
            action === OPEN_GENERATED_README
        ) {
            await openGeneratedReadme(
                workspaceRoot
            );
        }
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

async function openProjectStartPrompt(
    workspaceRoot: string
): Promise<void> {
    const promptPath = path.join(
        workspaceRoot,
        '.github',
        'prompts',
        'project-start.prompt.md'
    );

    await openGeneratedDocument(
        promptPath
    );
}

async function openGeneratedReadme(
    workspaceRoot: string
): Promise<void> {
    const readmePath = path.join(
        workspaceRoot,
        'README.md'
    );

    await openGeneratedDocument(
        readmePath
    );
}

async function openGeneratedDocument(
    filePath: string
): Promise<void> {
    try {
        const document =
            await vscode.workspace.openTextDocument(
                vscode.Uri.file(filePath)
            );

        await vscode.window.showTextDocument(
            document,
            {
                preview: false
            }
        );
    } catch (error: unknown) {
        const message =
            error instanceof Error
                ? error.message
                : String(error);

        await vscode.window.showErrorMessage(
            `Unable to open generated document: ${message}`
        );
    }
}