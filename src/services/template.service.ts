import * as vscode from 'vscode';

export type TemplateContext = Readonly<
    Record<string, string>
>;

export interface TemplateFile {
    relativePath: string;
    sourceUri: vscode.Uri;
}

export class TemplateService {
    public async findTemplates(
        rootUri: vscode.Uri
    ): Promise<TemplateFile[]> {
        const templates: TemplateFile[] = [];

        await this.walkDirectory(
            rootUri,
            '',
            templates
        );

        return templates.sort(
            (
                first,
                second
            ): number => first.relativePath.localeCompare(
                second.relativePath
            )
        );
    }

    public async readTemplate(
        uri: vscode.Uri
    ): Promise<string> {
        const content = await vscode.workspace.fs.readFile(uri);

        return new TextDecoder('utf-8').decode(content);
    }

    public render(
        template: string,
        context: TemplateContext
    ): string {
        let rendered = template;

        rendered = this.renderConditionalBlocks(
            rendered,
            context
        );

        rendered = rendered.replace(
            /\{\{([A-Z0-9_]+)\}\}/g,
            (
                match: string,
                key: string
            ): string => context[key] ?? match
        );

        this.assertNoUnresolvedVariables(
            rendered
        );

        return this.normalizeDocument(
            rendered
        );
    }

    private async walkDirectory(
        directoryUri: vscode.Uri,
        relativeDirectory: string,
        templates: TemplateFile[]
    ): Promise<void> {
        const entries = await vscode.workspace.fs.readDirectory(
            directoryUri
        );

        for (const [name, fileType] of entries) {
            const sourceUri = vscode.Uri.joinPath(
                directoryUri,
                name
            );

            const relativePath = relativeDirectory
                ? `${relativeDirectory}/${name}`
                : name;

            if (fileType === vscode.FileType.Directory) {
                await this.walkDirectory(
                    sourceUri,
                    relativePath,
                    templates
                );

                continue;
            }

            if (fileType !== vscode.FileType.File) {
                continue;
            }

            templates.push({
                relativePath,
                sourceUri
            });
        }
    }

    private renderConditionalBlocks(
        template: string,
        context: TemplateContext
    ): string {
        let rendered = template;
        let previousValue: string;

        const positivePattern =
            /\{\{#([A-Z0-9_]+)\}\}([\s\S]*?)\{\{\/\1\}\}/g;

        const negativePattern =
            /\{\{\^([A-Z0-9_]+)\}\}([\s\S]*?)\{\{\/\1\}\}/g;

        do {
            previousValue = rendered;

            rendered = rendered.replace(
                positivePattern,
                (
                    _match: string,
                    key: string,
                    content: string
                ): string => {
                    return this.isTruthy(context[key])
                        ? content
                        : '';
                }
            );

            rendered = rendered.replace(
                negativePattern,
                (
                    _match: string,
                    key: string,
                    content: string
                ): string => {
                    return this.isTruthy(context[key])
                        ? ''
                        : content;
                }
            );
        } while (rendered !== previousValue);

        return rendered;
    }

    private isTruthy(
        value: string | undefined
    ): boolean {
        return value === 'true';
    }

    private assertNoUnresolvedVariables(
        content: string
    ): void {
        const unresolvedConditional =
            content.match(
                /\{\{[#/^][A-Z0-9_]+\}\}/
            );

        if (unresolvedConditional) {
            throw new Error(
                `Unresolved template condition: ${unresolvedConditional[0]}`
            );
        }

        const unresolvedVariable =
            content.match(
                /\{\{[A-Z0-9_]+\}\}/
            );

        if (unresolvedVariable) {
            throw new Error(
                `Unresolved template variable: ${unresolvedVariable[0]}`
            );
        }
    }

    private normalizeDocument(
        content: string
    ): string {
        const normalized = content
            .replace(/\r\n/g, '\n')
            .replace(/[ \t]+\n/g, '\n')
            .replace(/^\n+/, '')
            .replace(/\n+$/, '');

        return `${normalized}\n`;
    }
}