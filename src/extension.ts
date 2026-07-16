import * as vscode from 'vscode';

import {
    newProjectCommand
} from './commands/new-project.command';

export function activate(
    context: vscode.ExtensionContext
): void {
    const newProjectDisposable =
        vscode.commands.registerCommand(
            'projectBuilder.newProject',

            async (): Promise<void> => {
                await newProjectCommand(
                    context.extensionUri
                );
            }
        );

    context.subscriptions.push(
        newProjectDisposable
    );
}

export function deactivate(): void {
}