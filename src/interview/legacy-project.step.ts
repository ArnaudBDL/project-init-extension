import {
    askBoolean
} from './boolean.step';

export async function askLegacyProject(): Promise<boolean | undefined> {
    return askBoolean(
        'Existing codebase to migrate',
        false
    );
}