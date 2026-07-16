export interface Shell {
    key: string;
    label: string;
}

export const DESKTOP_SHELLS: readonly Shell[] = [
    {
        key: 'tauri',
        label: 'Tauri'
    },
    {
        key: 'wails',
        label: 'Wails'
    },
    {
        key: 'electron',
        label: 'Electron'
    }
];

export const MOBILE_SHELLS: readonly Shell[] = [
    {
        key: 'capacitor',
        label: 'Capacitor'
    },
    {
        key: 'flutter',
        label: 'Flutter'
    },
    {
        key: 'react-native',
        label: 'React Native'
    }
];

export const WEB_SHELLS: readonly Shell[] = [
    {
        key: 'docker',
        label: 'Docker'
    }
];

export function getShellLabel(
    key: string,
    registry: readonly Shell[]
): string {
    if (key === 'none') {
        return 'None';
    }

    return registry.find(
        shell => shell.key === key
    )?.label ?? key;
}