/*    https://docs.rs/bcrypt/0.10.0/bcrypt/             */
extern crate bcrypt;

// hash() salt is generated randomly using the OS randomness
// hash_with_result() more useful Result. Can get Cost, Salt and Hash
use bcrypt::{hash, hash_with_result, hash_with_salt, verify};

fn main() -> std::io::Result<()> {
    let user_pswd: &'static str = "foobar1234";

    let user_a = hash(user_pswd, 10);
    let user_b = hash_with_result(user_pswd, 10);
    println!("User A: {} -> {:#?}", user_pswd, user_a);
    println!("User B: {} -> {:#?}", user_pswd, user_b);
    Ok(())
}


/*

User A: foobar1234 -> Ok(
    "$2b$10$rwun/Q.SzEdaFrU1CC7gYOTlBex/baccHlAE82kRCCv6gRHK/hkm.",
)
User B: foobar1234 -> Ok(
    HashParts {
        cost: 10,
        salt: "oZgvHKSLajzqy57D9NbDPe",
        hash: "SRZ6OBIau/7wF6zEOMuFwZKBiK4dglG",
    },
)

*/