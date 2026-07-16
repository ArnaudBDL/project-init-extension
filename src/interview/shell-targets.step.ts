import * as vscode from 'vscode';

import {
    ProjectProfile
} from '../models/project-profile';

import {
    DESKTOP_SHELLS,
    MOBILE_SHELLS,
    Shell
} from '../registries/shell.registry';

import {
    askBoolean
} from './boolean.step';

interface ShellQuickPickItem extends vscode.QuickPickItem {
    key: string;
}

async function askShell(
    placeHolder: string,
    registry: readonly Shell[]
): Promise<string | undefined> {
    const items: ShellQuickPickItem[] = registry.map(
        (shell): ShellQuickPickItem => ({
            key: shell.key,
            label: shell.label
        })
    );

    const selectedItem = await vscode.window.showQuickPick(
        items,
        {
            placeHolder,
            ignoreFocusOut: true
        }
    );

    return selectedItem?.key;
}

export async function askShellTargets(
    profile: ProjectProfile
): Promise<boolean> {
    profile.desktopShell = 'none';
    profile.mobileShell = 'none';
    profile.webShell = 'none';

    if (profile.frontendStack === 'none') {
        return true;
    }

    const desktopEnabled = await askBoolean(
        'Add desktop shell',
        true
    );

    if (desktopEnabled === undefined) {
        return false;
    }

    if (desktopEnabled) {
        const desktopShell = await askShell(
            'Select desktop shell',
            DESKTOP_SHELLS
        );

        if (desktopShell === undefined) {
            return false;
        }

        profile.desktopShell = desktopShell;
    }

    const mobileEnabled = await askBoolean(
        'Add mobile shell',
        true
    );

    if (mobileEnabled === undefined) {
        return false;
    }

    if (mobileEnabled) {
        const mobileShell = await askShell(
            'Select mobile shell',
            MOBILE_SHELLS
        );

        if (mobileShell === undefined) {
            return false;
        }

        profile.mobileShell = mobileShell;
    }

    const webEnabled = await askBoolean(
        'Add web shell',
        true
    );

    if (webEnabled === undefined) {
        return false;
    }

    if (webEnabled) {
        profile.webShell = 'docker';
    }

    return true;
}