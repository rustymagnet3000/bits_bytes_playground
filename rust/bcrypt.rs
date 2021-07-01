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

use bcrypt::{hash, hash_with_result, hash_with_salt, verify};

fn main() -> std::io::Result<()> {
    let user_pswd: &'static str = "foobar1234";
    let salt: [u8; 16] = [
        41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41,
    ];

    // user Alice
    let user_a_digest = hash_with_salt(user_pswd, 10, &salt);

    match user_a_digest {
        Ok(v) => {
            let hash = &v.to_string()[29..60];
            println!(
                "User A:\n\tHash:    \t{}\n\tSalt:    \t{:?}\n\tCost:    \t{}\n\tFull:    \t{}",
                hash,
                salt,
                v.get_cost(),
                v.to_string(),
            );
            let verify_result = verify(user_pswd, &v.to_string());
            println!(
                "User A verify:\n\tPassword:\t{}\n\tverify:  \t{:?}",
                user_pswd, verify_result
            );
        }
        Err(e) => println!("error getting hash: {:?}", e),
    }

    // user Bob
    let user_b_digest = hash_with_result(user_pswd, 10);
    match user_b_digest {
        Ok(v) => {
            let hash = &v.to_string()[29..60];
            println!(
                "User B:\n\tHash:    \t{}\n\tSalt:    \t{:?}\n\tCost:    \t{}\n\tFull:    \t{}",
                hash,
                v.get_salt().as_bytes(),
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

    // user Yves
    let user_y_digest = hash(user_pswd, 10);
    println!(
        "User Y verify:\n\tPassword:\t{}\n\tDigest:\t{:#?}",
        user_pswd, user_y_digest
    );
    let verify_result = verify(user_pswd, &user_y_digest.unwrap());
    println!("User Y verify:\t{:?}", verify_result);

    Ok(())
}

/*
User A:
    Hash:    	XuCckwAXCWFtjphH5ibTCVZ1O0rkLpG
    Salt:    	[41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41]
    Cost:    	10
    Full:    	$2y$10$IQinIQinIQinIQinIQinIOXuCckwAXCWFtjphH5ibTCVZ1O0rkLpG
User A verify:
    Password:	foobar1234
    verify:  	Ok(true)
User B:
    Hash:    	p0yHwGVyOqJG9Qwp86M/DjNLQU5bDaq
    Salt:    	[104, 111, 117, 88, 52, 70, 74, 90, 118, 66, 102, 52, 85, 119, 80, 74, 66, 81, 85, 87, 81, 46]
    Cost:    	10
    Full:    	$2y$10$houX4FJZvBf4UwPJBQUWQ.p0yHwGVyOqJG9Qwp86M/DjNLQU5bDaq
User B verify:
    Password:	foobar1234
    verify:  	Ok(true)
User Y verify:
    Password:	foobar1234
    Digest:	Ok(
    "$2b$10$Ws5jYTNFJkofM5VgFCNgCOs2R5qecngGqqHWB1fp.4pJ1U3pYiLoK",
)
User Y verify:	Ok(true)

Process finished with exit code 0

 */
