/*    if let VS match   */

fn main() {
    let name= Some("kermit");

    // exhaustive
    match name {
        Some(n) => println!("{}", n),
        None => println!("nothing found")
    }

    // not exhaustive. Notice optional else case not added
    if let Some(n) = name {
        println!("[*]{}", n);
    }

}