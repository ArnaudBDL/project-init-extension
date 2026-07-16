import * as vscode from 'vscode';

import {
    FRONTEND_STACKS
} from '../registries/frontend.registry';

interface FrontendStackQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

export async function askFrontendStack(): Promise<string | undefined> {
    const items: FrontendStackQuickPickItem[] = [
        ...FRONTEND_STACKS.map(
            (stack): FrontendStackQuickPickItem => ({
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
            placeHolder: 'Select frontend stack',
            ignoreFocusOut: true
        }
    );

    return selectedItem?.key;
}