extern crate serde_json;
#[macro_use]
extern crate serde_derive;

#[derive(Serialize, Deserialize)]
struct Person {
    name: String,
    age: u32,
    vip: bool
}

fn main() {

    let json_str = r#"
        {
            "name": "foobar",
            "age": 99,
            "vip": true
        }
    "#;


    /*
    Change a field in the json_str to cause this error:
        thread 'main' panicked at 'Problem decoding: Error("missing field `vip`", line: 6, column: 9)',
    */
        
    let p: Person = match serde_json::from_str (json_str) {
        Ok (p) => p,
        Err (e) => { panic!("Problem decoding: {:?}", e) },
    };

    println!("Name is: {}", p.name);
    println!("VIP: {}", p.vip);
}