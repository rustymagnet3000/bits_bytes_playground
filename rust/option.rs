
// An enum called Option<T> instead of None.
// It manifests itself as one of two "options":
// Some(T): An element of type T was found
// None: No element was found

fn next_birthday(current_age: Option<u8>) -> Option<String> {
    // If `current_age` is `None`, this returns `None`.
    // If `current_age` is `Some`, the inner `u8` gets assigned to `next_age`
    let next_age: u8 = current_age?;
    Some(format!("Next year I will be {}", next_age))
}

fn main() {
    let a:u8 = 8;
    let s_a: Option<u8> = None;
    let mut n: Option<u8>;

    let result: Result<u8, &str> = Ok(a);
    assert_eq!(result.unwrap(), a);

    // cast Result into Option
    n = result.ok();
    
    println!(
        "Hello {:#?}",
        next_birthday(n)
    );
    println!(
        "Hello {:#?}",
        next_birthday(s_a)
    );

}

/*
Hello Some(
    "Next year I will be 8",
)
Hello None

 */