# Rust

### Set up

```bash
curl https://sh.rustup.rs -sSf | sh
cargo --version && rustc --version
rustc --version
rustup --version
rustup doc --book
rustup toolchain install nightly
source $HOME/.cargo/env
https://blog.logrocket.com/getting-up-to-speed-with-rust/
```

### Update

```bash
rustup update
cargo update
```

### Set toolchain

```bash
rustup default stable
```

### Create new project

```bash
https://rust-cli.github.io/book/tutorial/setup.html
cargo new grrs
cargo new guessing_game
```

### Build and run

```bash
rustc main.rs		// only for the smallest scripts
cargo build
cargo build --release	// optimizations for a Release build
cargo run		// build and run a project in one step
cargo check		// build a project without producing a binary to check for errors
cargo metadata --no-deps
cargo metadata --no-deps --format-version=1 | jq .
```

#### Debugging

```bash
rustc --explain E0425
```
