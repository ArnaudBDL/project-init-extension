import * as vscode from 'vscode';

import {
    GenerationReport
} from '../models/generation-report';

import {
    ProjectProfile
} from '../models/project-profile';

import {
    FilesystemService
} from '../services/filesystem.service';

import {
    TemplateContext,
    TemplateFile,
    TemplateService
} from '../services/template.service';

import {
    createGenericSkillTemplateContext,
    createRemoteServiceContext,
    createTemplateContext,
    getSelectedSkillKeys
} from '../templates/template-context';

const SPECIALIZED_SKILL_KEYS =
    new Set<string>([
        'angular',
        'html-js-css',
        'go',
        'tauri',
        'docker',
        'sqlite'
    ]);

export class ProjectGenerator {
    private readonly filesystemService =
        new FilesystemService();

    private readonly templateService =
        new TemplateService();

    public constructor(
        private readonly extensionUri:
            vscode.Uri
    ) {
    }

    public async generate(
        profile: ProjectProfile
    ): Promise<GenerationReport> {
        const report: GenerationReport = {
            createdFiles: [],
            skippedFiles: [],
            createdDirectories: []
        };

        const scaffoldRootUri =
            vscode.Uri.joinPath(
                this.extensionUri,
                'resources',
                'scaffold'
            );

        const workspaceRootUri =
            vscode.Uri.file(
                profile.workspaceRoot
            );

        if (
            !(await this.filesystemService.exists(
                scaffoldRootUri
            ))
        ) {
            throw new Error(
                'The embedded scaffold directory is missing.'
            );
        }

        const context =
            createTemplateContext(
                profile
            );

        const templates =
            await this.templateService
                .findTemplates(
                    scaffoldRootUri
                );

        const generatedDirectories =
            new Set<string>();

        for (
            const template
            of templates
        ) {
            if (
                !this.shouldGenerateTemplate(
                    template,
                    profile
                )
            ) {
                continue;
            }

            await this.generateTemplate(
                template,
                context,
                workspaceRootUri,
                report,
                generatedDirectories
            );
        }

        await this.generateGenericSkills(
            profile,
            workspaceRootUri,
            report,
            generatedDirectories
        );

        await this.generateRemoteServices(
            profile,
            workspaceRootUri,
            report,
            generatedDirectories
        );

        await this.cleanupGeneratedDirectories(
            workspaceRootUri,
            generatedDirectories
        );

        report.createdDirectories.push(
            ...Array.from(
                generatedDirectories
            ).sort()
        );

        return report;
    }

    private async generateTemplate(
        template: TemplateFile,
        context: TemplateContext,
        workspaceRootUri: vscode.Uri,
        report: GenerationReport,
        generatedDirectories:
            Set<string>
    ): Promise<void> {
        const templateContent =
            await this.templateService
                .readTemplate(
                    template.sourceUri
                );

        const renderedContent =
            this.templateService.render(
                templateContent,
                context
            );

        const relativePath =
            this.templateService.renderPath(
                template.relativePath,
                context
            );

        const targetUri =
            vscode.Uri.joinPath(
                workspaceRootUri,
                ...relativePath.split('/')
            );

        const result =
            await this.filesystemService
                .writeFile(
                    targetUri,
                    renderedContent,
                    false
                );

        if (result.created) {
            report.createdFiles.push(
                relativePath
            );
        } else {
            report.skippedFiles.push(
                relativePath
            );
        }

        this.collectParentDirectories(
            relativePath,
            generatedDirectories
        );
    }

    private async generateGenericSkills(
        profile: ProjectProfile,
        workspaceRootUri: vscode.Uri,
        report: GenerationReport,
        generatedDirectories:
            Set<string>
    ): Promise<void> {
        const genericTemplateUri =
            vscode.Uri.joinPath(
                this.extensionUri,
                'resources',
                'templates',
                'skills',
                'generic',
                'SKILL.md'
            );

        const genericSkillKeys =
            getSelectedSkillKeys(
                profile
            ).filter(
                skill =>
                    !SPECIALIZED_SKILL_KEYS
                        .has(skill)
            );

        if (
            genericSkillKeys.length === 0
        ) {
            return;
        }

        if (
            !(await this.filesystemService
                .exists(
                    genericTemplateUri
                ))
        ) {
            throw new Error(
                'The generic skill template is missing: resources/templates/skills/generic/SKILL.md'
            );
        }

        const genericTemplate =
            await this.templateService
                .readTemplate(
                    genericTemplateUri
                );

        for (
            const skillKey
            of genericSkillKeys
        ) {
            const relativePath = [
                '00-META',
                'skills',
                skillKey,
                'SKILL.md'
            ].join('/');

            const targetUri =
                vscode.Uri.joinPath(
                    workspaceRootUri,
                    ...relativePath.split(
                        '/'
                    )
                );

            const context =
                createGenericSkillTemplateContext(
                    profile,
                    skillKey
                );

            const renderedContent =
                this.templateService.render(
                    genericTemplate,
                    context
                );

            const result =
                await this.filesystemService
                    .writeFile(
                        targetUri,
                        renderedContent,
                        false
                    );

            if (result.created) {
                report.createdFiles.push(
                    relativePath
                );
            } else {
                report.skippedFiles.push(
                    relativePath
                );
            }

            this.collectParentDirectories(
                relativePath,
                generatedDirectories
            );
        }
    }

    private async generateRemoteServices(
        profile: ProjectProfile,
        workspaceRootUri: vscode.Uri,
        report: GenerationReport,
        generatedDirectories:
            Set<string>
    ): Promise<void> {
        if (
            profile
                .remoteServerArchitecture !==
            'microservices'
        ) {
            return;
        }

        const templateUri =
            vscode.Uri.joinPath(
                this.extensionUri,
                'resources',
                'templates',
                'engineering',
                'server-domain-service',
                'README.md'
            );

        if (
            !(await this.filesystemService
                .exists(
                    templateUri
                ))
        ) {
            throw new Error(
                'The remote service README template is missing: resources/templates/engineering/server-domain-service/README.md'
            );
        }

        const templateContent =
            await this.templateService
                .readTemplate(
                    templateUri
                );

        for (
            const domain
            of profile
                .remoteServiceDomains
        ) {
            const context =
                createRemoteServiceContext(
                    profile,
                    domain
                );

            const renderedContent =
                this.templateService.render(
                    templateContent,
                    context
                );

            const relativePath = [
                '04-ENGINEERING',
                'server',
                'remote',
                [
                    profile.projectSlug,
                    'server',
                    domain,
                    'service'
                ].join('-'),
                'README.md'
            ].join('/');

            const targetUri =
                vscode.Uri.joinPath(
                    workspaceRootUri,
                    ...relativePath.split(
                        '/'
                    )
                );

            const result =
                await this.filesystemService
                    .writeFile(
                        targetUri,
                        renderedContent,
                        false
                    );

            if (result.created) {
                report.createdFiles.push(
                    relativePath
                );
            } else {
                report.skippedFiles.push(
                    relativePath
                );
            }

            this.collectParentDirectories(
                relativePath,
                generatedDirectories
            );
        }
    }

    private shouldGenerateTemplate(
        template: TemplateFile,
        profile: ProjectProfile
    ): boolean {
        const path =
            template.relativePath;

        if (
            path.includes(
                '__PROJECT_SLUG__-backoffice/'
            ) &&
            !profile.backofficeEnabled
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-frontoffice/'
            ) &&
            profile.frontendStack ===
                'none'
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-server-modules/'
            ) &&
            profile.backendStack ===
                'none'
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-server-local/'
            ) &&
            !profile.serverLocalEnabled
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-server-remote/'
            ) &&
            profile
                .remoteServerArchitecture !==
                'monolith'
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-server-assets/'
            ) &&
            !profile.serverAssetsEnabled
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-shell-desktop/'
            ) &&
            profile.desktopShell ===
                'none'
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-shell-mobile/'
            ) &&
            profile.mobileShell ===
                'none'
        ) {
            return false;
        }

        if (
            path.includes(
                '__PROJECT_SLUG__-shell-web/'
            ) &&
            profile.webShell ===
                'none'
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/client/'
            ) &&
            profile.frontendStack ===
                'none'
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/'
            ) &&
            !this.hasServer(
                profile
            )
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/modules/'
            ) &&
            profile.backendStack ===
                'none'
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/local/'
            ) &&
            !profile.serverLocalEnabled
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/remote/'
            ) &&
            profile
                .remoteServerArchitecture ===
                'none'
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/shell/'
            ) &&
            !this.hasShell(
                profile
            )
        ) {
            return false;
        }

        if (
            path.startsWith(
                '09-LEGACY/'
            ) &&
            !profile.legacyEnabled
        ) {
            return false;
        }

        return this
            .shouldGenerateSkillTemplate(
                path,
                profile
            );
    }

    private shouldGenerateSkillTemplate(
        path: string,
        profile: ProjectProfile
    ): boolean {
        const match = path.match(
            /^00-META\/skills\/([^/]+)\//
        );

        if (!match) {
            return true;
        }

        const skillKey = match[1];

        if (
            skillKey === 'kanban' ||
            skillKey === 'specs'
        ) {
            return true;
        }

        return getSelectedSkillKeys(
            profile
        ).includes(
            skillKey
        );
    }

    private hasServer(
        profile: ProjectProfile
    ): boolean {
        return (
            profile.backendStack !==
                'none' ||
            profile.serverLocalEnabled ||
            profile
                .remoteServerArchitecture !==
                'none' ||
            profile.serverAssetsEnabled
        );
    }

    private hasShell(
        profile: ProjectProfile
    ): boolean {
        return (
            profile.desktopShell !==
                'none' ||
            profile.mobileShell !==
                'none' ||
            profile.webShell !==
                'none'
        );
    }

    private collectParentDirectories(
        relativePath: string,
        generatedDirectories:
            Set<string>
    ): void {
        const parts =
            relativePath.split('/');

        parts.pop();

        while (
            parts.length > 0
        ) {
            generatedDirectories.add(
                parts.join('/')
            );

            parts.pop();
        }
    }

    private async cleanupGeneratedDirectories(
        workspaceRootUri: vscode.Uri,
        generatedDirectories:
            Set<string>
    ): Promise<void> {
        const directories =
            Array.from(
                generatedDirectories
            ).sort(
                (
                    first,
                    second
                ): number =>
                    second.split('/')
                        .length -
                    first.split('/')
                        .length
            );

        for (
            const directory
            of directories
        ) {
            const directoryUri =
                vscode.Uri.joinPath(
                    workspaceRootUri,
                    ...directory.split('/')
                );

            await this.filesystemService
                .cleanupGitkeep(
                    directoryUri
                );
        }
    }
}