import * as vscode from 'vscode';

function getWorkspaceFolder(): vscode.WorkspaceFolder {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];

    if (!workspaceFolder) {
        throw new Error(
            'No workspace folder is currently open.'
        );
    }

    return workspaceFolder;
}

export function getWorkspaceRoot(): string {
    return getWorkspaceFolder().uri.fsPath;
}

export function getWorkspaceName(): string {
    return getWorkspaceFolder().name;
}