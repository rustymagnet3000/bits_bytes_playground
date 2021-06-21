extern crate serde_json;
use serde_json::Value as JsonValue;

// https://www.youtube.com/watch?v=hIi_UlyIPMg

fn main() {
    let json_str = r#"
        {
            "name": "foobar",
            "age": 99,
            "vip": true
        }
    "#;

    let res = serde_json::from_str(json_str);

    if res.is_ok(){
        let p: JsonValue = res.unwrap();        // de-serialize
        println!("Name is: {}", p["name"]);
        println!("Name is: {}", p["name"].as_str().unwrap());
    } else {
        println!("Json parsing failed");
    }
}

