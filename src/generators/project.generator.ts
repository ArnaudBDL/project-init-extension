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
    TemplateFile,
    TemplateService
} from '../services/template.service';

import {
    createTemplateContext,
    getSelectedSkillKeys
} from '../templates/template-context';

const PERMANENT_SKILL_KEYS = [
    'kanban',
    'specs'
] as const;

export class ProjectGenerator {
    private readonly filesystemService =
        new FilesystemService();

    private readonly templateService =
        new TemplateService();

    public constructor(
        private readonly extensionUri: vscode.Uri
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

        const scaffoldRootUri = vscode.Uri.joinPath(
            this.extensionUri,
            'resources',
            'scaffold'
        );

        const workspaceRootUri = vscode.Uri.file(
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

        await this.validateRequiredSkills(
            scaffoldRootUri,
            profile
        );

        const context = createTemplateContext(
            profile
        );

        const templates =
            await this.templateService.findTemplates(
                scaffoldRootUri
            );

        const generatedDirectories = new Set<string>();

        for (const template of templates) {
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

    private async validateRequiredSkills(
        scaffoldRootUri: vscode.Uri,
        profile: ProjectProfile
    ): Promise<void> {
        const requiredSkillKeys = [
            ...getSelectedSkillKeys(profile),
            ...PERMANENT_SKILL_KEYS
        ];

        const invalidSkills: string[] = [];

        for (const skillKey of requiredSkillKeys) {
            const skillUri = vscode.Uri.joinPath(
                scaffoldRootUri,
                '00-META',
                'skills',
                skillKey,
                'SKILL.md'
            );

            if (
                !(await this.filesystemService.exists(
                    skillUri
                ))
            ) {
                invalidSkills.push(
                    `${skillKey}: missing 00-META/skills/${skillKey}/SKILL.md`
                );

                continue;
            }

            const content =
                await this.filesystemService.readFile(
                    skillUri
                );

            if (content.trim() === '') {
                invalidSkills.push(
                    `${skillKey}: empty 00-META/skills/${skillKey}/SKILL.md`
                );
            }
        }

        if (invalidSkills.length > 0) {
            throw new Error(
                [
                    'Required specialized skills are missing or empty:',
                    ...invalidSkills.map(
                        skill => `- ${skill}`
                    )
                ].join('\n')
            );
        }
    }

    private async generateTemplate(
        template: TemplateFile,
        context: Readonly<Record<string, string>>,
        workspaceRootUri: vscode.Uri,
        report: GenerationReport,
        generatedDirectories: Set<string>
    ): Promise<void> {
        const templateContent =
            await this.templateService.readTemplate(
                template.sourceUri
            );

        const renderedContent =
            this.templateService.render(
                templateContent,
                context
            );

        const targetUri = vscode.Uri.joinPath(
            workspaceRootUri,
            ...template.relativePath.split('/')
        );

        const result =
            await this.filesystemService.writeFile(
                targetUri,
                renderedContent,
                false
            );

        if (result.created) {
            report.createdFiles.push(
                template.relativePath
            );
        } else {
            report.skippedFiles.push(
                template.relativePath
            );
        }

        this.collectParentDirectories(
            template.relativePath,
            generatedDirectories
        );
    }

    private shouldGenerateTemplate(
        template: TemplateFile,
        profile: ProjectProfile
    ): boolean {
        const path = template.relativePath;

        const hasFrontend =
            profile.frontendStack !== 'none';

        const hasServer =
            profile.backendStack !== 'none' ||
            profile.serverLocalEnabled ||
            profile.serverRemoteEnabled ||
            profile.serverAssetsEnabled;

        const hasShell =
            profile.desktopShell !== 'none' ||
            profile.mobileShell !== 'none' ||
            profile.webShell !== 'none';

        if (
            path.startsWith(
                '04-ENGINEERING/client/'
            ) &&
            !hasFrontend
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/'
            ) &&
            !hasServer
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/modules/'
            ) &&
            profile.backendStack === 'none'
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
            !profile.serverRemoteEnabled
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/server/assets/'
            ) &&
            !profile.serverAssetsEnabled
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/shell/'
            ) &&
            !hasShell
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/shell/desktop/'
            ) &&
            profile.desktopShell === 'none'
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/shell/mobile/'
            ) &&
            profile.mobileShell === 'none'
        ) {
            return false;
        }

        if (
            path.startsWith(
                '04-ENGINEERING/shell/web/'
            ) &&
            profile.webShell === 'none'
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

        return this.shouldGenerateSkillTemplate(
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

    private collectParentDirectories(
        relativePath: string,
        generatedDirectories: Set<string>
    ): void {
        const parts = relativePath.split('/');

        parts.pop();

        while (parts.length > 0) {
            generatedDirectories.add(
                parts.join('/')
            );

            parts.pop();
        }
    }

    private async cleanupGeneratedDirectories(
        workspaceRootUri: vscode.Uri,
        generatedDirectories: Set<string>
    ): Promise<void> {
        const directories = Array.from(
            generatedDirectories
        ).sort(
            (
                first,
                second
            ): number =>
                second.split('/').length -
                first.split('/').length
        );

        for (const directory of directories) {
            const directoryUri = vscode.Uri.joinPath(
                workspaceRootUri,
                ...directory.split('/')
            );

            await this.filesystemService.cleanupGitkeep(
                directoryUri
            );
        }
    }
}
