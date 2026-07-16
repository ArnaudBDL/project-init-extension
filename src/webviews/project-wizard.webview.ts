import * as vscode from 'vscode';

export function openProjectWizard(): void {

    const panel = vscode.window.createWebviewPanel(
        'projectBuilder',
        'Project Builder',
        vscode.ViewColumn.One,
        {
            enableScripts: true
        }
    );

    panel.webview.html = `
    <!DOCTYPE html>
    <html>
    <body>

        <h1>Project Builder</h1>

        <label>Project Name</label>
        <input type="text" />

        <button>Generate</button>

    </body>
    </html>
    `;
}