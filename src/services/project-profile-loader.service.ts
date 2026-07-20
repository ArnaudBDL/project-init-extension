import * as fs from 'fs';

import {
    parse
} from 'yaml';

import {
    ProjectProfile
} from '../models/project-profile';

import {
    createProjectProfile
} from './project-profile.service';

interface StackProject {
    name?: unknown;
    slug?: unknown;
}

interface StackFrontend {
    enabled?: unknown;
    stack?: unknown;
    name?: unknown;
    variant?: unknown;
    variantName?: unknown;
    frontoffice?: unknown;
    backoffice?: unknown;
}

interface StackServerRemote {
    enabled?: unknown;
    architecture?: unknown;
    assets?: unknown;
    serviceDomains?: unknown;
}

interface StackServer {
    enabled?: unknown;
    stack?: unknown;
    name?: unknown;
    framework?: unknown;
    frameworkName?: unknown;
    local?: unknown;
    remote?: unknown;
}

interface StackDataService {
    key?: unknown;
    name?: unknown;
}

interface StackData {
    databases?: unknown;
    searchEngines?: unknown;
}

interface StackShellTarget {
    enabled?: unknown;
    stack?: unknown;
    name?: unknown;
}

interface StackShell {
    desktop?: unknown;
    mobile?: unknown;
    web?: unknown;
}

interface StackLegacy {
    enabled?: unknown;
    codebase?: unknown;
    migration?: unknown;
}

interface StackDocument {
    project?: unknown;
    frontend?: unknown;
    server?: unknown;
    data?: unknown;
    shell?: unknown;
    legacy?: unknown;
}

export function loadProjectProfile(
    workspaceRoot: string,
    stackFile: string
): ProjectProfile {
    const content = fs.readFileSync(
        stackFile,
        'utf8'
    );

    const document = parseStackDocument(
        content,
        stackFile
    );

    const project = asObject<StackProject>(
        document.project
    );

    const frontend = asObject<StackFrontend>(
        document.frontend
    );

    const server = asObject<StackServer>(
        document.server
    );

    const remoteServer =
        asObject<StackServerRemote>(
            server.remote
        );

    const data = asObject<StackData>(
        document.data
    );

    const shell = asObject<StackShell>(
        document.shell
    );

    const desktopShell =
        asObject<StackShellTarget>(
            shell.desktop
        );

    const mobileShell =
        asObject<StackShellTarget>(
            shell.mobile
        );

    const webShell =
        asObject<StackShellTarget>(
            shell.web
        );

    const legacy = asObject<StackLegacy>(
        document.legacy
    );

    const profile = createProjectProfile(
        workspaceRoot
    );

    profile.projectName = readRequiredString(
        project.name,
        'project.name',
        stackFile
    );

    profile.projectSlug = readRequiredString(
        project.slug,
        'project.slug',
        stackFile
    );

    profile.frontendStack = readString(
        frontend.stack,
        'none'
    );

    profile.frontendVariant = readString(
        frontend.variant,
        'none'
    );

    profile.backofficeEnabled = readBoolean(
        frontend.backoffice
    );

    profile.backendStack = readString(
        server.stack,
        'none'
    );

    profile.backendFramework = readString(
        server.framework,
        'none'
    );

    profile.serverLocalEnabled = readBoolean(
        server.local
    );

    profile.remoteServerArchitecture =
        readRemoteServerArchitecture(
            remoteServer.architecture,
            'server.remote.architecture',
            stackFile
        );

    profile.remoteServiceDomains =
        readStringArray(
            remoteServer.serviceDomains,
            'server.remote.serviceDomains',
            stackFile
        );

    profile.serverAssetsEnabled = readBoolean(
        remoteServer.assets
    );

    profile.databases = readDataServiceKeys(
        data.databases,
        'data.databases',
        stackFile
    );

    profile.searchEngines = readDataServiceKeys(
        data.searchEngines,
        'data.searchEngines',
        stackFile
    );

    profile.desktopShell = readString(
        desktopShell.stack,
        'none'
    );

    profile.mobileShell = readString(
        mobileShell.stack,
        'none'
    );

    profile.webShell = readString(
        webShell.stack,
        'none'
    );

    profile.legacyEnabled = readBoolean(
        legacy.enabled
    );

    validateProjectProfile(
        profile,
        stackFile
    );

    return profile;
}

function parseStackDocument(
    content: string,
    stackFile: string
): StackDocument {
    let parsed: unknown;

    try {
        parsed = parse(content);
    } catch (error: unknown) {
        const message =
            error instanceof Error
                ? error.message
                : String(error);

        throw new Error(
            `Unable to parse ${stackFile}: ${message}`
        );
    }

    if (!isRecord(parsed)) {
        throw new Error(
            `Invalid stack profile in ${stackFile}: expected a YAML object.`
        );
    }

    return parsed as StackDocument;
}

function readRemoteServerArchitecture(
    value: unknown,
    propertyName: string,
    stackFile: string
): ProjectProfile['remoteServerArchitecture'] {
    if (
        value === 'none' ||
        value === 'monolith' ||
        value === 'microservices'
    ) {
        return value;
    }

    throw new Error(
        [
            `Invalid stack profile in ${stackFile}:`,
            `${propertyName} must be one of:`,
            'none, monolith, microservices.'
        ].join(' ')
    );
}

function readStringArray(
    value: unknown,
    propertyName: string,
    stackFile: string
): string[] {
    if (
        value === undefined ||
        value === null
    ) {
        return [];
    }

    if (!Array.isArray(value)) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                `${propertyName} must be an array.`
            ].join(' ')
        );
    }

    return value.map(
        (
            item: unknown,
            index: number
        ): string => readRequiredString(
            item,
            `${propertyName}[${index}]`,
            stackFile
        )
    );
}

function readDataServiceKeys(
    value: unknown,
    propertyName: string,
    stackFile: string
): string[] {
    if (
        value === undefined ||
        value === null
    ) {
        return [];
    }

    if (!Array.isArray(value)) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                `${propertyName} must be an array.`
            ].join(' ')
        );
    }

    return value.map(
        (
            item: unknown,
            index: number
        ): string => {
            const dataService =
                asObject<StackDataService>(
                    item
                );

            return readRequiredString(
                dataService.key,
                `${propertyName}[${index}].key`,
                stackFile
            );
        }
    );
}

function readRequiredString(
    value: unknown,
    propertyName: string,
    stackFile: string
): string {
    if (
        typeof value !== 'string' ||
        value.trim() === ''
    ) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                `${propertyName} must be a non-empty string.`
            ].join(' ')
        );
    }

    return value;
}

function readString(
    value: unknown,
    fallback: string
): string {
    if (
        typeof value !== 'string' ||
        value.trim() === ''
    ) {
        return fallback;
    }

    return value;
}

function readBoolean(
    value: unknown
): boolean {
    return value === true;
}

function validateProjectProfile(
    profile: ProjectProfile,
    stackFile: string
): void {
    if (
        profile.frontendStack === 'none' &&
        profile.backofficeEnabled
    ) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                'frontend.backoffice cannot be enabled',
                'when frontend.stack is none.'
            ].join(' ')
        );
    }

    if (
        profile.remoteServerArchitecture ===
            'microservices' &&
        profile.remoteServiceDomains.length === 0
    ) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                'server.remote.serviceDomains must contain',
                'at least one domain when',
                'server.remote.architecture is microservices.'
            ].join(' ')
        );
    }

    if (
        profile.remoteServerArchitecture !==
            'microservices' &&
        profile.remoteServiceDomains.length > 0
    ) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                'server.remote.serviceDomains must be empty unless',
                'server.remote.architecture is microservices.'
            ].join(' ')
        );
    }

    if (
        profile.remoteServerArchitecture ===
            'none' &&
        profile.serverAssetsEnabled
    ) {
        throw new Error(
            [
                `Invalid stack profile in ${stackFile}:`,
                'server.remote.assets cannot be enabled when',
                'server.remote.architecture is none.'
            ].join(' ')
        );
    }
}

function asObject<T>(
    value: unknown
): T {
    if (!isRecord(value)) {
        return {} as T;
    }

    return value as T;
}

function isRecord(
    value: unknown
): value is Record<string, unknown> {
    return (
        typeof value === 'object' &&
        value !== null &&
        !Array.isArray(value)
    );
}