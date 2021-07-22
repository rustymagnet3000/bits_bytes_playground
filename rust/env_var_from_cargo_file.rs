// Bad idea

pub fn get_app_version()  ->  String {
    let version = match env::var("CARGO_PKG_VERSION"){
        Ok (v) => v,
        Err (_) => ("0.0.0").to_string()
    };
    version
}



// Good idea
// https://stackoverflow.com/questions/27840394/how-can-a-rust-program-access-metadata-from-its-cargo-package

const VERSION: &'static str = env!("CARGO_PKG_VERSION");
println!("{}", VERSION);


// You can also make it optional but this is worthless as Rust strictly checks for the presence of the `version` string inside Cargo.toml, at compile time
const VERSION: Option<&'static str> = option_env!("CARGO_PKG_VERSION");
println!("{}", VERSION.unwrap_or("unknown"));
