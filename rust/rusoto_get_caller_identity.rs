extern crate rusoto_core;
use rusoto_core::Region;
use rusoto_sts::{StsClient, Sts, GetCallerIdentityRequest};

/*  export AWS_PROFILE=rm_rusoto_demo       */

#[tokio::main]
async fn main() {
    println!("[*]Started. Trying to get a the AWS Caller Identity...");
    let sts = StsClient::new(Region::EuWest1);

    match sts.get_caller_identity(GetCallerIdentityRequest {}).await {
        Ok(r) => {
            println!("User ID: {:?}", r.user_id.unwrap());
            println!("ARN    : {:?}", r.arn.unwrap());
            println!("Account: {:?}", r.account.unwrap());
        },
        Err(e) => panic!("[!]Could not retrieve caller ID: {:?}", e),
    }
}