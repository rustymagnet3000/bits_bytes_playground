fn main() {

    let mut config = Config::new();

    // Error: `Config` cannot be formatted with the default formatter
    // println!("Config: {}", config);

    //  normal print
    println!("Config:  {:?}", config);

    //  pretty-print
    println!("Config:  {:#?}", config);
}