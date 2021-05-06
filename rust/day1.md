

#### Set up

```bash
curl https://sh.rustup.rs -sSf | sh
cargo --version && rustc --version
rustc --version
rustup doc --book
source $HOME/.cargo/env
cargo version
```

#### Build and run

```bash
cargo build
cargo run
cargo check
```

#### VS code set up

code --install-extension matklad.rust-analyzer
code --install-extension vadimcn.vscode-lldb


#### Debugging

```
rustc --explain E0425
```