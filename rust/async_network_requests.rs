/*
I had to use v1.6.0 of tokio to avoid "thread 'main' panicked at 'there is no reactor running, must be called from the context of a Tokio 1.x runtime' ""
[dependencies]
error-chain = "0.12.4"
reqwest = { version = "0.11.3", features = ["blocking"] }
tokio = { version = "1.6.0", features = ["full"] }
 */

use error_chain::error_chain;

error_chain! {
    foreign_links {
        Io(std::io::Error);
        HttpRequest(reqwest::Error);
    }
}

#[tokio::main]
async fn main() -> Result<()> {
    let res = reqwest::get("https://httpbin.org/get").await?;
    println!("Status: {}", res.status());
    println!("Headers:\n{:#?}", res.headers());

    let body = res.text().await?;
    println!("Body:\n{}", body);
    Ok(())
}
