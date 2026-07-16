import * as vscode from 'vscode';

interface BooleanQuickPickItem extends vscode.QuickPickItem {
    value: boolean;
}

export async function askBoolean(
    placeHolder: string,
    defaultValue: boolean
): Promise<boolean | undefined> {
    const yesItem: BooleanQuickPickItem = {
        label: defaultValue ? 'Yes (default)' : 'Yes',
        value: true
    };

    const noItem: BooleanQuickPickItem = {
        label: defaultValue ? 'No' : 'No (default)',
        value: false
    };

    const items = defaultValue
        ? [yesItem, noItem]
        : [noItem, yesItem];

    const selectedItem = await vscode.window.showQuickPick(
        items,
        {
            placeHolder,
            ignoreFocusOut: true
        }
    );

    return selectedItem?.value;
}