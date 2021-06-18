use std::collections::HashMap;
use config::{Config, File, FileFormat};

// https://github.com/mehcode/config-rs/blob/master/examples/simple/src/main.rs

fn main() {

    let mut config = Config::new();

    // required(true) will cause a Thread Panic, if the file cannot be found
    config.merge(File::new("config/Settings", FileFormat::Toml).required(true)).unwrap();
    println!("[*]Config:  {:#?}", config);

    // This line causes "value used here after move"
    // println!("{:?}", config.try_into::<HashMap<String, String>>().unwrap());

    let settings = config.try_into::<HashMap<String, String>>().unwrap();
    if !settings.contains_key("deb2ug") {
        println!("We've got {} settings but not that one!",
                 settings.len());
    }

    // print all settings
    for (val, key) in &settings {
        println!("{}: \"{}\"", val, key);
    }
}

