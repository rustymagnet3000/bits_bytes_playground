let x = format!("{}, {}!", "Hello", "world");
println!("{}", x); // Hello, world!

let y = String::from("Hello, ") + "world!";
println!("{}", y); // Hello, world!

println!("{:#?}", [1,2,3]);
/*
    [
        1,
        2,
        3
    ]
*/