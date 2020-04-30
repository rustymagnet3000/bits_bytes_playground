typedef NS_ENUM(NSInteger, GuessedType) {
    DEC_STRING,
    HEX_STRING,
    ASCII_STRING,
    UNKNOWN
};

@implementation FooBar: NSObject

+ (void) guessFormatOfDecryptedType: (NSString *)input{

    GuessedType result = UNKNOWN;

    NSCharacterSet *hexChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet];
    NSCharacterSet *decimalChars = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSCharacterSet *alphanumericChars = [[NSCharacterSet alphanumericCharacterSet] invertedSet];

    if ([input rangeOfCharacterFromSet:hexChars].location == NSNotFound){
        result = HEX_STRING;
        NSLog(@"NSString. Guessed hex: %@", input);
    }
    else if ([input rangeOfCharacterFromSet:decimalChars].location == NSNotFound){
        result = DEC_STRING;
        NSLog(@"Guessing, Dec: %@", input);
    }
    else if ([input rangeOfCharacterFromSet:alphanumericChars].location == NSNotFound){
        result = DEC_STRING;
        NSLog(@"Guessing, alphanumeric: %@", input);
    }
    else{
        result = UNKNOWN;
        NSLog(@"Don't know.  %@", input);
    }
}
@end
