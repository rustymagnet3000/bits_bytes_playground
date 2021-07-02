#[macro_use]
extern crate serde_derive;

use serde_json::Result;

#[derive(Deserialize)]
pub struct RoleRequest {
    #[serde(rename = "roleZ")]
    role: String,
    reason: String,
    ticket: Option<String>,
}

fn main() -> Result<()> {
    // Trigger error by enter /// after curly opening bracket
    let str = "{\"roleZ\":\"yyyyy\",\"reason\":\"solve a puzzle\",\"ticket\":\"105\"}";

    let role_req = serde_json::from_str::<RoleRequest>(str)?;
    println!("[*]{}", role_req.role);
    println!("[*]{}", role_req.reason);
    println!("[*]{:?}", role_req.ticket);
    Ok(())
}

/*
    [*]yyyyy
    [*]solve a puzzle
    [*]Some("105")
 */
