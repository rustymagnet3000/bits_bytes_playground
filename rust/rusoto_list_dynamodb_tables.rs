extern crate rusoto_core;
extern crate rusoto_dynamodb;

/*
    Active credential set:      cat ~/.aws/credentials
    export AWS_PROFILE=rm_rusoto_demo
    AWS_REGION set in code
*/

use std::default::Default;

use rusoto_core::Region;
use rusoto_dynamodb::{DynamoDb, DynamoDbClient, ListTablesInput};

fn main() {
    let client = DynamoDbClient::new(Region::EuWest2);

    let list_tables_request = ListTablesInput::default();

    match client.list_tables(list_tables_request).sync() {
        Ok(output) => {
            for i in output.table_names {
                println!("Tables found: {:?}", i);
            }
        }
        Err(error) => {
            println!("Error: {:?}", error);
        }
    };
}
