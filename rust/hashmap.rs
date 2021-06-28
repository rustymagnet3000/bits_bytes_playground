/*
    match, remove() and get() value from Hashmap or print no match
 */
use std::collections::HashMap;

fn main() {
    let mut hm = HashMap::new();
    hm.insert(String::from("Alice"), 77);
    hm.insert(String::from("Bob"), 66);
    hm.insert(String::from("Yves"), 66);

    hm.remove(&String::from("Yves"));
    for(k,v) in &hm {
        println!("{}:{}", k, v);
    }

    let names = ["Bob", "Yves"];
    for name in &names {
        check(&hm,name);
    }
}

pub fn check (hm: &HashMap<String, i32>, name: &str){
    match hm.get(&String::from(name)) {
        Some(&n) => println!("Value: {}", n),
        _ => println!("[!]no match"),       // if None
    }
}