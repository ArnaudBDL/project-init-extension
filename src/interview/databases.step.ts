import * as vscode from 'vscode';

import {
    DATABASES
} from '../registries/data.registry';

interface DatabaseQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

export async function askDatabases(): Promise<string[] | undefined> {
    const items: DatabaseQuickPickItem[] = DATABASES.map(
        (database): DatabaseQuickPickItem => ({
            key: database.key,
            label: database.label
        })
    );

    const selectedItems = await vscode.window.showQuickPick(
        items,
        {
            placeHolder: 'Select databases and data stores',
            ignoreFocusOut: true,
            canPickMany: true
        }
    );

    if (selectedItems === undefined) {
        return undefined;
    }

    return selectedItems.map(
        item => item.key
    );
}