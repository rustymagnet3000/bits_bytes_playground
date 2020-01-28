/*
    https://joris.kluivers.nl/blog/2012/03/13/new-objectivec-literal-syntax/
    https://www.bignerdranch.com/blog/objective-c-literals-part-1/
*/
 
int main(void) {
    @autoreleasepool {
        
            // original syntax
            NSDictionary *origDict = [NSDictionary dictionaryWithObjectsAndKeys:
              @"Yves", @"Foo",
              @"Nancy", @"Bar",
            nil];

            NSLog (@"orig dictionary: %@", origDict);
            
            // literal syntax
            NSDictionary *litDict = @{ @"Alice" :  @"Foo", @"Bob" :  @"Bar" };
            NSLog (@"Literal dictionary: %@", litDict);
    }
}

