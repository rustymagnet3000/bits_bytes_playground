extern crate serde_json;
#[macro_use]
extern crate serde_derive;
extern crate serde_path_to_error;

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

    /*
    Change a field in the json_str to cause this error:
        thread 'main' panicked at 'Problem decoding: Error("missing field `vip`", line: 6, column: 9)',
    */
    let deserializer = &mut serde_json::Deserializer::from_str(json_str);
    let result: Result<Person, _> = serde_path_to_error::deserialize(deserializer);
    match result {
        Ok(p) => {
            println!("Name is: {}", p.name);
            println!("VIP: {}", p.vip);
        }
        Err(err) => {
            panic!("[!]{:?}", err)
        }
    };
}
