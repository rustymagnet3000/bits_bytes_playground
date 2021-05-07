#### Set up

```bash
curl https://sh.rustup.rs -sSf | sh
cargo --version && rustc --version
rustc --version
rustup doc --book
source $HOME/.cargo/env
cargo version
```

#### Update

```bash
rustup update
```

#### Create new project

```bash
https://rust-cli.github.io/book/tutorial/setup.html
cargo new grrs
cargo new guessing_game
```

#### Build and run

```bash
rustc main.rs		// only for the smallest scripts
cargo build
cargo build --release	// optimizations for a Release build
cargo run		// build and run a project in one step
cargo check		// build a project without producing a binary to check for errors
cargo metadata --no-deps
cargo metadata --no-deps --format-version=1 | jq .
```

#### VS code set up

```bash
code --install-extension matklad.rust-analyzer
code --install-extension vadimcn.vscode-lldb
```

#### Style

- Rust style is to indent with four spaces, not a tab.
- `!` means that you’re calling a macro instead of a normal function.

#### Debugging

```
rustc --explain E0425
```

#### Debugging set up in VScode

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

#### Get Run button to work in VSCode


```json
	-->	/VScode/Preferences/Settings.json


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


#### Tests

```rust
#[test]
fn it_works() {
    assert_eq!(2 + 2, 4);
}
```
