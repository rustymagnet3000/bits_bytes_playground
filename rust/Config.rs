use std::collections::HashMap;
use config::{Config, File, FileFormat};

fn main() {

    let mut config = Config::new();

    // required(true) will cause a Thread Panic, if file cannot be found
    config.merge(File::new("config/Settings", FileFormat::Toml).required(true)).unwrap();

    /*
        The following line will fail if you get an individual item from the Config file.
        It expects a Map like this:
            [server]
            debug = false
            priority = 32
            key = "aaaasecretkeyaaaa"
     */

    let settings = config.get::<HashMap<String, String>>("server");

    if settings.is_ok(){
        println!("settings ok");
        let res = settings.unwrap();
        if !res.contains_key("debug") {
            println!("We've got {} settings but not that one!",
                     res.len());
        }
        for (val, key) in &res {
            println!("{}: \"{}\"", val, key);
        }
    }
}