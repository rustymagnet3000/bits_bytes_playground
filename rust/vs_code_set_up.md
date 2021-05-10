# Rust

## VSCode set up

### Extensions

```bash
code --install-extension matklad.rust-analyzer		// Required for good auto-complete
code --install-extension vadimcn.vscode-lldb		// Required for debugging on macOS
```

### Debugging launch file

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "lldb",
            "request": "launch",
            "name": "Debug executable 'grrs'",
            "cargo": {
                "args": [
                    "build",
                    "--bin=grrs",
                    "--package=grrs"
                ],
                "filter": {
                    "name": "grrs",
                    "kind": "bin"
                }
            },
            "args": [],
            "cwd": "${workspaceFolder}"
        },
        {
            "type": "lldb",
            "request": "launch",
            "name": "Debug unit tests in executable 'grrs'",
            "cargo": {
                "args": [
                    "test",
                    "--no-run",
                    "--bin=grrs",
                    "--package=grrs"
                ],
                "filter": {
                    "name": "grrs",
                    "kind": "bin"
                }
            },
            "args": [],
            "cwd": "${workspaceFolder}"
        }
    ]
}
```

### Run button in VSCode

Inside `/VScode/Preferences/Settings.json`:

```json
	-->	


{
    "explorer.confirmDelete": false,
    "files.autoSave": "afterDelay",
    ....
    ...
    ..
    "code-runner.executorMap": {
        "rust": "if [ $(basename $dir) = 'examples' ]; then cargo run --example $fileNameWithoutExt; else cargo run; fi",
    }
}
```

#### Accept user input

Inside `/VScode/Preferences/Settings.json`:

```bash
    "code-runner.runInTerminal": true
    }
```
