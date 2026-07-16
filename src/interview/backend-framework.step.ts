import * as vscode from 'vscode';

import {
    BACKEND_FRAMEWORKS
} from '../registries/backend.registry';

interface BackendFrameworkQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

export async function askBackendFramework(
    backendStack: string
): Promise<string | undefined> {
    if (backendStack === 'none') {
        return 'none';
    }

    const frameworks = BACKEND_FRAMEWORKS[backendStack] ?? [];

    if (frameworks.length === 0) {
        return 'none';
    }

    const items: BackendFrameworkQuickPickItem[] = [
        ...frameworks.map(
            (framework): BackendFrameworkQuickPickItem => ({
                key: framework.key,
                label: framework.label
            })
        ),
        {
            key: 'none',
            label: 'None'
        }
    ];

    const selectedItem = await vscode.window.showQuickPick(
        items,
        {
            placeHolder: 'Select backend framework',
            ignoreFocusOut: true
        }
    );

    return selectedItem?.key;
}