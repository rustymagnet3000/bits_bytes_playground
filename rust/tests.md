# Rust

## Tests

### Run all tests

`cargo test -- --nocapture`

### Run a single test

`cargo test this_test_will_pass`

### Show values and Pass/Fail details

`cargo test -- --show-output`

### Stop tests running in parallel

`cargo test -- --test-threads=1`

### Json output

```cargo test --color=always --no-fail-fast --all-features -- --format=json -Z unstable-options --show-output```

## Define a test

```rust
#[test]
fn it_works() {
    assert_eq!(2 + 2, 4);
}
```

### [cfg(test)] annotation

>The `#[cfg(test)]` annotation on the tests module tells Rust to compile and run the test code only when you run cargo test, not when you run cargo build. This saves compile time when you only want to build the library and saves space in the resulting compiled artifact because the tests are not included.

```rust
fn prints_and_returns_10(a: i32) -> i32 {
    println!("I got the value {}", a);
    10
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn this_test_will_pass() {
        let value = prints_and_returns_10(10);
        assert_eq!(10, value);
    }

    #[test]
    fn this_test_will_fail() {
        let value = prints_and_returns_10(8);
        assert_eq!(5, value);
    }
}
```
