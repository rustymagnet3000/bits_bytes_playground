extern crate serde_json;
#[macro_use]
extern crate serde_derive;

// https://www.youtube.com/watch?v=hIi_UlyIPMg

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

    let res = serde_json::from_str(json_str);

    if res.is_ok(){
        let p: Person = res.unwrap();
        println!("Name is: {}", p.name);
        println!("VIP: {}", p.vip);
    } else {
        println!("Json parsing failed");
    }
}

