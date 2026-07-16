import * as fs from 'fs';
import * as path from 'path';

export function getExistingStackFile(
    workspaceRoot: string
): string | undefined {
    const stackFile = path.join(
        workspaceRoot,
        '00-META',
        'context',
        'stack.yml'
    );

    if (!fs.existsSync(stackFile)) {
        return undefined;
    }

    return stackFile;
}