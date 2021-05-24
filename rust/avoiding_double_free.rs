// https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html
// Rust will never automatically create “deep” copies of your data. Therefore, any automatic copying can be assumed to be inexpensive in terms of runtime performance.

fn main() {
    let s1 = String::from("hello");
    let s2 = s1;
    println!("{}, world!", s1);
}

// 2 |     let s1 = String::from("hello");
//   |         -- move occurs because `s1` has type `String`, which does not implement the `Copy` trait
// 3 |     let s2 = s1;
//   |              -- value moved here
// 4 |     println!("{}, world!", s1);
//   |                            ^^ value borrowed here after move

// If we do want to deeply copy the heap data of the String, not just the stack data, we can use a common method called clone.

fn main() {
    let s1 = String::from("hello");
    let _s2 = s1.clone();
    println!("{}, world!", s1);
}
