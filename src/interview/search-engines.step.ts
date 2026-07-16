import * as vscode from 'vscode';

import {
    SEARCH_ENGINES
} from '../registries/data.registry';

interface SearchEngineQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

export async function askSearchEngines(): Promise<string[] | undefined> {
    const items: SearchEngineQuickPickItem[] = SEARCH_ENGINES.map(
        (searchEngine): SearchEngineQuickPickItem => ({
            key: searchEngine.key,
            label: searchEngine.label
        })
    );

    const selectedItems = await vscode.window.showQuickPick(
        items,
        {
            placeHolder: 'Select search engines',
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