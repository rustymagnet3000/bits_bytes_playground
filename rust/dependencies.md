# Rust

### Dependencies

The `Cargo.toml` file includes all dependencies.  You have to explicity add "optional modules" if that is how they are marked by the dependency:

```rust
Cargo.toml
----------
[dependencies]
error-chain = "0.12.4"
reqwest = { version = "0.11.3", features = ["blocking"] }
```

These build the `Cargo.lock` file that includes hashes of versions used.

### Check for unused dependencies

```bash
cargo install cargo-udeps --locked
cargo +nightly udeps
cargo +nightly udeps --all-targets
```

### Create dependencies and sub depedencies

```bash
cargo tree -d
```
