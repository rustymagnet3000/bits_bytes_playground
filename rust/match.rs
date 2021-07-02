extern crate serde_json;
#[macro_use]
extern crate serde_derive;

/* the panic really helps a concisely written match statement */

#[derive(Serialize, Deserialize)]
struct Person {
    name: String,
    age: u32,
    vip: bool,
}

fn main() {
    let json_str = r#"
        {
            "name": "foobar",
            "age": 99,
            "vipp": true
        }
    "#;

    let p: Person = match serde_json::from_str (json_str) {
        Ok (p) => p,
        Err (e) => { panic!("[!]{:?}", e) },
    };

    println!("Name is: {}", p.name);
    println!("VIP: {}", p.vip);
}