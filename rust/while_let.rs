/*
    while let
 */

 fn main() {
    let mut num = Some(0);

    while let Some(n) = num {
        if n > 19 {
            println!("Quit");
            num = None;
        }
        else {
            println!("{}",n);
            num = Some(n + 3);
        }
    }
}