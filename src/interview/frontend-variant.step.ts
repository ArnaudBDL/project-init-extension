import * as vscode from 'vscode';

import {
    FRONTEND_VARIANTS
} from '../registries/frontend.registry';

interface FrontendVariantQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

export async function askFrontendVariant(
    frontendStack: string
): Promise<string | undefined> {
    if (frontendStack === 'none') {
        return 'none';
    }

    const variants = FRONTEND_VARIANTS[frontendStack] ?? [];

    if (variants.length === 0) {
        return 'none';
    }

    const items: FrontendVariantQuickPickItem[] = [
        ...variants.map(
            (variant): FrontendVariantQuickPickItem => ({
                key: variant.key,
                label: variant.label
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
            placeHolder: 'Select frontend variant',
            ignoreFocusOut: true
        }
    );

    return selectedItem?.key;
}