

#### Set up

```bash
curl https://sh.rustup.rs -sSf | sh
cargo --version && rustc --version
rustc --version
rustup doc --book
source $HOME/.cargo/env
cargo version
```

#### Create new app

```bash
https://rust-cli.github.io/book/tutorial/setup.html
cargo new grrs
```


#### Build and run

```bash
cargo build
cargo run
cargo check
cargo metadata --no-deps
cargo metadata --no-deps --format-version=1 | jq .
```

#### VS code set up

code --install-extension matklad.rust-analyzer
code --install-extension vadimcn.vscode-lldb


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

#### Tests

```rust
#[test]
fn it_works() {
    assert_eq!(2 + 2, 4);
}
```
