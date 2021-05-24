/*
Cargo.toml
----------
[dependencies]
error-chain = "0.12.4"
reqwest = { version = "0.11.3", features = ["blocking"] }

NOTE -> blocking is an Optional feature, so it has to be explicitly added to the Cargo.toml file
*/

use error_chain::error_chain;
use std::io::Read;

error_chain! {
    foreign_links {
        Io(std::io::Error);
        HttpRequest(reqwest::Error);
    }
}

fn main() -> Result<()> {
    let mut res = reqwest::blocking::get("https://httpbin.org/get")?;
    let mut body = String::new();
    res.read_to_string(&mut body)?;

    println!("Status: {}", res.status());
    println!("Headers:\n{:#?}", res.headers());
    println!("Body:\n{}", body);

    Ok(())
}