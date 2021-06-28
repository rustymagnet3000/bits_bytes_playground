/*
    Vectors can grow and shrink at run-time [ unlike fixed sized Arrays ]
    Vectors can only have ONE type of Type
    v.push(6);          would generate a Type compile time error
 */

 fn main() {

    let mut v = Vec::new();
    v.push("foo");
    v.push("bar");
    v.push("bar");
    println!("Length:{}\tCapacity:{}", v.len(), v.capacity());
    v.pop();

    for i in &v{
        println!("{}", i);
    }
    println!("Length:{}\tCapacity:{}", v.len(), v.capacity());
}

/* 
    Length:3	Capacity:4
    foo
    bar
    Length:2	Capacity:4
 */