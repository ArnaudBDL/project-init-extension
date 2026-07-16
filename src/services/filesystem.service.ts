import * as vscode from 'vscode';

export interface WriteFileResult {
    created: boolean;
    path: string;
}

export class FilesystemService {
    public async exists(
        uri: vscode.Uri
    ): Promise<boolean> {
        try {
            await vscode.workspace.fs.stat(uri);

            return true;
        } catch {
            return false;
        }
    }

    public async createDirectory(
        uri: vscode.Uri
    ): Promise<void> {
        await vscode.workspace.fs.createDirectory(uri);
    }

    public async readFile(
        uri: vscode.Uri
    ): Promise<string> {
        const content = await vscode.workspace.fs.readFile(uri);

        return new TextDecoder('utf-8').decode(content);
    }

    public async writeFile(
        uri: vscode.Uri,
        content: string,
        overwrite = false
    ): Promise<WriteFileResult> {
        const fileExists = await this.exists(uri);

        if (fileExists && !overwrite) {
            return {
                created: false,
                path: uri.fsPath
            };
        }

        const parentUri = vscode.Uri.joinPath(
            uri,
            '..'
        );

        await this.createDirectory(parentUri);

        await vscode.workspace.fs.writeFile(
            uri,
            new TextEncoder().encode(content)
        );

        return {
            created: true,
            path: uri.fsPath
        };
    }

    public async readDirectory(
        uri: vscode.Uri
    ): Promise<[string, vscode.FileType][]> {
        return vscode.workspace.fs.readDirectory(uri);
    }

    public async deleteFile(
        uri: vscode.Uri
    ): Promise<void> {
        if (!(await this.exists(uri))) {
            return;
        }

        await vscode.workspace.fs.delete(
            uri,
            {
                recursive: false,
                useTrash: false
            }
        );
    }

    public async cleanupGitkeep(
        directoryUri: vscode.Uri
    ): Promise<void> {
        if (!(await this.exists(directoryUri))) {
            return;
        }

        const entries = await this.readDirectory(
            directoryUri
        );

        const hasGitkeep = entries.some(
            ([name]) => name === '.gitkeep'
        );

        if (!hasGitkeep || entries.length <= 1) {
            return;
        }

        await this.deleteFile(
            vscode.Uri.joinPath(
                directoryUri,
                '.gitkeep'
            )
        );
    }
}