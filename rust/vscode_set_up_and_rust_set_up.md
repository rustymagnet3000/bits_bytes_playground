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

#### Update

```bash
cargo install cargo-udeps --locked
cargo +nightly udeps
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

#### VSCode set up

```bash
code --install-extension matklad.rust-analyzer		// Required for good auto-complete
code --install-extension vadimcn.vscode-lldb		// Required for debugging on macOS
```

#### Style

- Rust style is to indent with four spaces, not a tab.
- `!` means that you’re calling a macro instead of a normal function.
- variables are immutable by default.
- like variables, references are immutable by default.
- Better to split up lines: `io::stdin().read_line(&mut guess).expect("Failed to read line");`
- expect will cause the program to crash

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

#### Get Run button working in VSCode

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


#### Accept user input

Inside `/VScode/Preferences/Settings.json`:


```bash
    "code-runner.runInTerminal": true
    }
```

#### Tests

```rust
#[test]
fn it_works() {
    assert_eq!(2 + 2, 4);
}
```
