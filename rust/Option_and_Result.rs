/*
https://learning-rust.github.io/docs/e3.option_and_result.html
Many languages use null\ nil\ undefined types to represent empty outputs, and Exceptions to handle errors. Rust skips using both, especially to prevent issues like null pointer exceptions, sensitive data leakages through exceptions and etc. Instead, Rust provides two special generic enums;Option and Result to deal
*/

// An output can have either Some value or no value/ None.
enum Option<T> { // T is a generic and it can contain any type of value.
    Some(T),
    None,
}

// A result can represent either success/ Ok or failure/ Err.
enum Result<T, E> { // T and E are generics. T can contain any type of value, E can be any error.
    Ok(T),
    Err(E),
}