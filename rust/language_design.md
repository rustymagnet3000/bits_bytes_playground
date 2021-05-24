# Rust

### Language

- Rust is a `statically typed language`; it must know the types of all variables at compile time.
- Rust’s central feature is `ownership`.  memory is managed through a system of ownership with a set of rules that the compiler checks at compile time.

```rust
// https://www.integralist.co.uk/posts/rust-ownership/

fn main() {
    let mut s = String::from("foo");
    println!("s: {}", s); // s: foo
    borrow(&mut s);
    println!("s: {}", s); // s: foobar
    take_ownership(s);
    println!("s: {}", s); // <-- COMPILE ERROR (ownership of s was moved)
}

fn borrow(s: &mut String) {
    s.push_str("bar");
}

fn take_ownership(s: String) {
    println!("s: {}", s); // s: foobar
}
```

- variables are immutable by default.
- like variables, references are immutable by default.
- Rust uses the term `panick` when a program exits with an error
- [Integer Overflow](https://doc.rust-lang.org/book/ch03-02-data-types.html) on a release build `wraps around`.
- If we do want to deeply copy the heap data of the String, not just the stack data, we can use a common method called `clone`.
- Rust will never automatically create “deep” copies of your data.  It is avoiding `double free` issues.
- when a variable goes out of scope, Rust automatically calls the `drop function` and cleans up the heap memory for that variable.

## Style

### Design

- Rust code uses snake case as the conventional style for function and variable names.
- Rust style is to indent with four spaces, not a tab.
- `!` means that you’re calling a macro instead of a normal function.
- an underscore: `_guess`to represent an unused variable
- Better to split up lines: `io::stdin().read_line(&mut guess).expect("Failed to read line");`
- `expect` will cause the program to crash
- declare constants using the `const` keyword instead of the `let` keyword
- you aren’t allowed to use `mut` with `constants`
- Why not ban variable [shadowing](https://stackoverflow.com/questions/59860476/what-is-the-rationale-behind-allowing-variable-shadowing-in-rust#:~:text=It%20does%2C%20but%20Rust%20allows,a%20different%20variable%20creates%20bugs)?

### Optionals

Unlike languages such as Ruby and JavaScript, Rust will not automatically try to convert non-Boolean types to a Boolean.

```rust
    if number {                 <-- compile error!
        println!("number was three");
    }
--------------------------------
    if number != 0 {
        println!("number was something other than zero");
    }
```

### Return value in Function

```rust
fn plus_one(x: i32) -> i32 {
    x + 1
}

fn plus_one(x: i32) -> i32 {
    x + 1;
}
```

### Rust has no ternary operator

```rust
let condition = true;
let number = if condition { 5 } else { 6 };
```
