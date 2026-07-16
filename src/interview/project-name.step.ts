import * as vscode from 'vscode';

export interface ProjectIdentity {
    name: string;
    slug: string;
}

export async function askProjectName(
    workspaceName: string
): Promise<ProjectIdentity | undefined> {
    const projectName = await vscode.window.showInputBox({
        prompt: 'Enter project name',
        placeHolder: workspaceName,
        value: workspaceName,
        ignoreFocusOut: true,
        validateInput: (
            value: string
        ): string | undefined => {
            if (!value.trim()) {
                return 'Project name cannot be empty.';
            }

            if (!slugify(value)) {
                return 'Project name must contain letters or numbers.';
            }

            return undefined;
        }
    });

    if (projectName === undefined) {
        return undefined;
    }

    const normalizedName = projectName.trim();

    return {
        name: normalizedName,
        slug: slugify(normalizedName)
    };
}

function slugify(value: string): string {
    return value
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/^-+|-+$/g, '');
}