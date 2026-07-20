import * as vscode from 'vscode';

export async function askRemoteServiceDomains():
Promise<string[] | undefined> {
    const domains: string[] = [];

    while (true) {
        const domain =
            await vscode.window.showInputBox({
                prompt:
                    domains.length === 0
                        ? 'Enter the first microservice domain'
                        : 'Enter another microservice domain or leave empty to finish',

                placeHolder:
                    domains.length === 0
                        ? 'identity'
                        : 'Leave empty to finish',

                ignoreFocusOut: true,

                validateInput: (
                    value: string
                ): string | undefined => {
                    const normalizedValue =
                        normalizeDomain(value);

                    if (
                        !normalizedValue &&
                        domains.length === 0
                    ) {
                        return 'At least one microservice domain is required.';
                    }

                    if (
                        normalizedValue &&
                        !isValidDomain(normalizedValue)
                    ) {
                        return 'Use lowercase letters, numbers and hyphens only.';
                    }

                    if (
                        normalizedValue &&
                        domains.includes(normalizedValue)
                    ) {
                        return 'This microservice domain is already selected.';
                    }

                    return undefined;
                }
            });

        if (domain === undefined) {
            return undefined;
        }

        const normalizedDomain =
            normalizeDomain(domain);

        if (!normalizedDomain) {
            return domains;
        }

        domains.push(normalizedDomain);
    }
}

function normalizeDomain(
    value: string
): string {
    return value
        .trim()
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/^-+|-+$/g, '');
}

function isValidDomain(
    value: string
): boolean {
    return /^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(
        value
    );
}