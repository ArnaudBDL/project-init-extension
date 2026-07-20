import {
    ProjectProfile
} from '../models/project-profile';

import {
    askBoolean
} from './boolean.step';

import {
    askRemoteServerArchitecture
} from './remote-architecture.step';

import {
    askRemoteServiceDomains
} from './remote-services.step';

export async function askServerTargets(
    profile: ProjectProfile
): Promise<boolean> {
    resetServerTargets(profile);

    if (profile.backendStack === 'none') {
        return true;
    }

    const localServerEnabled = await askBoolean(
        'Add local server',
        true
    );

    if (localServerEnabled === undefined) {
        return false;
    }

    profile.serverLocalEnabled = localServerEnabled;

    const remoteArchitecture =
        await askRemoteServerArchitecture();

    if (remoteArchitecture === undefined) {
        return false;
    }

    profile.remoteServerArchitecture =
        remoteArchitecture;

    if (
        profile.remoteServerArchitecture ===
        'microservices'
    ) {
        const remoteServiceDomains =
            await askRemoteServiceDomains();

        if (remoteServiceDomains === undefined) {
            return false;
        }

        profile.remoteServiceDomains =
            remoteServiceDomains;
    }

    if (
        profile.remoteServerArchitecture !==
        'none'
    ) {
        const assetsEnabled = await askBoolean(
            'Add remote asset server',
            false
        );

        if (assetsEnabled === undefined) {
            return false;
        }

        profile.serverAssetsEnabled =
            assetsEnabled;
    }

    return true;
}

function resetServerTargets(
    profile: ProjectProfile
): void {
    profile.serverLocalEnabled = false;
    profile.remoteServerArchitecture = 'none';
    profile.remoteServiceDomains = [];
    profile.serverAssetsEnabled = false;
}