/*
    Foobar is a single Type ( an Enum ) so these can be stored in a Vector
    But it doesn't store them as you might expect ( see below debug output )
    You can concatenate Vectors together 
 */

#[derive(Debug)]

enum Foobar {
    Name(String),
    Age(u32)
}

fn main() {

    let mut r = vec![
        Foobar::Name(String::from("Alice")),
        Foobar::Age(72)
    ];

    println!("R\tLength:{}\tCapacity:{}", r.len(), r.capacity());

    let mut v = vec![
        Foobar::Name(String::from("Bob")),
        Foobar::Age(77)
    ];
    println!("V\tLength:{}\tCapacity:{}", v.len(), v.capacity());
    v.append(&mut r);

    for i in &v{
        println!("{:?}", i);
    }
}

/*
    R	Length:2	Capacity:2
    V	Length:2	Capacity:2
    Name("Bob")
    Age(77)
    Name("Alice")
    Age(72)
 */