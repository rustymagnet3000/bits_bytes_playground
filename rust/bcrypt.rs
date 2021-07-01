extern crate bcrypt;

/*
https://docs.rs/bcrypt/0.10.0/bcrypt/

$2b$[cost]$[22 character salt][31 character hash]
For example:

$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
\__/\/ \____________________/\_____________________________/
Alg Cost      Salt                        Hash

hash() rhe salt is generated randomly using the OS randomness
hash_with_salt() is when you input the salt
hash_with_result() returns a more useful Result HashParts so you can get Cost, Salt and Hash
*/

use bcrypt::{hash, hash_with_result, verify};

fn main() -> std::io::Result<()> {
    let user_pswd: &'static str = "foobar1234";

    // user A
    let user_a_digest = hash(user_pswd, 10);
    println!("User A: {} -> {:#?}", user_pswd, user_a_digest);
    println!(
        "User A verify:\n\tPassword:\t{}\n\tverify:  \t{:?}",
        user_pswd, user_a_digest
    );

    // user B
    let user_b_digest = hash_with_result(user_pswd, 10);
    match user_b_digest {
        Ok(v) => {
            let hash = &v.to_string()[29..60];
            println!(
                "User B:\n\tHash:    \t{}\n\tCost:    \t{}\n\tSalt:    \t{}\n\tFull:    \t{}",
                hash,
                v.get_salt(),
                v.get_cost(),
                v.to_string(),
            );
            let verify_result = verify(user_pswd, &v.to_string());
            println!(
                "User B verify:\n\tPassword:\t{}\n\tverify:  \t{:?}",
                user_pswd, verify_result
            );
        }
        Err(e) => println!("error getting hash: {:?}", e),
    }

    Ok(())
}
/*

User A: foobar1234 -> Ok(
    "$2b$10$oHcZ0Sg.Ar.LEfcbAWW5mu2LEYDx..Fwan.wbgUP8uswWKHhupEJG",
)
User A verify:
    Password:	foobar1234
    verify:  	Ok("$2b$10$oHcZ0Sg.Ar.LEfcbAWW5mu2LEYDx..Fwan.wbgUP8uswWKHhupEJG")
User B:
    Hash:    	e.HTsCV7SLM8WsO4cd.KgLVgPiGWGz6
    Cost:    	wfVoSBwItHWJ4T0BSe.H9e
    Salt:    	10
    Full:    	$2y$10$wfVoSBwItHWJ4T0BSe.H9ee.HTsCV7SLM8WsO4cd.KgLVgPiGWGz6
User B verify:
    Password:	foobar1234
    verify:  	Ok(true)

*/
