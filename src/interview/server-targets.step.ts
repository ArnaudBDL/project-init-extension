import {
    ProjectProfile
} from '../models/project-profile';

import {
    askBoolean
} from './boolean.step';

export async function askServerTargets(
    profile: ProjectProfile
): Promise<boolean> {
    profile.serverLocalEnabled = false;
    profile.serverRemoteEnabled = false;
    profile.serverAssetsEnabled = false;

    if (profile.backendStack !== 'none') {
        const localServer = await askBoolean(
            'Add local server',
            true
        );

        if (localServer === undefined) {
            return false;
        }

        profile.serverLocalEnabled = localServer;

        const remoteServer = await askBoolean(
            'Add remote server',
            true
        );

        if (remoteServer === undefined) {
            return false;
        }

        profile.serverRemoteEnabled = remoteServer;
    }

    const assetServer = await askBoolean(
        'Add asset server',
        false
    );

    if (assetServer === undefined) {
        return false;
    }

    profile.serverAssetsEnabled = assetServer;

    return true;
}