import * as vscode from 'vscode';

import {
    BACKEND_STACKS
} from '../registries/backend.registry';

interface BackendStackQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

export async function askBackendStack(): Promise<string | undefined> {
    const items: BackendStackQuickPickItem[] = [
        ...BACKEND_STACKS.map(
            (stack): BackendStackQuickPickItem => ({
                key: stack.key,
                label: stack.label
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
            placeHolder: 'Select backend stack',
            ignoreFocusOut: true
        }
    );

    return selectedItem?.key;
}