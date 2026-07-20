import * as vscode from 'vscode';

import {
    RemoteServerArchitecture
} from '../models/project-profile';

import {
    REMOTE_SERVER_ARCHITECTURES
} from '../registries/server-architecture.registry';

interface RemoteArchitectureQuickPickItem
    extends vscode.QuickPickItem {
    key: RemoteServerArchitecture;
}

export async function askRemoteServerArchitecture():
Promise<RemoteServerArchitecture | undefined> {
    const items: RemoteArchitectureQuickPickItem[] =
        REMOTE_SERVER_ARCHITECTURES.map(
            (
                architecture
            ): RemoteArchitectureQuickPickItem => ({
                key: architecture.key,
                label: architecture.label,
                description: architecture.description
            })
        );

    const selectedItem =
        await vscode.window.showQuickPick(
            items,
            {
                placeHolder:
                    'Select remote server architecture',
                ignoreFocusOut: true
            }
        );

    return selectedItem?.key;
}