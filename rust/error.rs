fn fails() -> Result<(), &'static str> {
    Err("some runtime error")
}

fn main() {
    //   = note: this `Result` may be an `Err` variant, which should be handled
    let result = fails();
    if result.is_err(){
        println!("Error found {:#?}", result.err());
    }
}