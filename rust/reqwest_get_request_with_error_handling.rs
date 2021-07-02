/*
cargo.toml:  reqwest = { version = "0.11.4", features = ["blocking", "json"]}
*/

use std::collections::HashMap;

fn main() {
    match get_current_date() {
        Ok(date) => println!("Found the year! {}!!", date),
        Err(e) => eprintln!("Couldn't find the year\n\t{}", e),
    }
}

fn get_current_date() -> Result<String, reqwest::Error> {
    let url = "https://postman-echo.com/time/object";
    let result = reqwest::blocking::get(url);

    let response = match result {
        Ok(res) => res,
        Err(err) => return Err(err),
    };

    let body = response.json::<HashMap<String, i32>>();

    let json = match body {
        Ok(json) => json,
        Err(err) => return Err(err),
    };

    let date = json["years"].to_string();

    Ok(date)
}
