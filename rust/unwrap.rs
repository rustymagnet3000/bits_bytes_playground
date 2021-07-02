use std::env;
use std::fs;

fn main() {
    // unwrap and expect
    let content = fs::read_to_string("./Cargo.toml").expect("Can't read Cargo.toml");
    println!("{}", content);

    // unwrap or default value
    let port = env::var("PORT").unwrap_or("3000".to_string());
    println!("{}", port);
}
