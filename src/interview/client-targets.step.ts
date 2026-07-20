import {
    ProjectProfile
} from '../models/project-profile';

import {
    askBoolean
} from './boolean.step';

export async function askClientTargets(
    profile: ProjectProfile
): Promise<boolean> {
    profile.backofficeEnabled = false;

    if (profile.frontendStack === 'none') {
        return true;
    }

    const backofficeEnabled = await askBoolean(
        'Add backoffice',
        false
    );

    if (backofficeEnabled === undefined) {
        return false;
    }

    profile.backofficeEnabled = backofficeEnabled;

    return true;
}