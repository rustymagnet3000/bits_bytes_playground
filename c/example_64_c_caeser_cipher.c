#include <stdio.h>

#define MAX_ALPHABET 26

// Build a cipher function that takes two parameters
// cipher(input_text: String, shift_key: u32) -> string
// cipher("hello", 1) -> "ifmmp"
// cipher("hello", 26) -> "hello"


void
cipher (char *input_text, unsigned int shift_key) {
  
    for(int i = 0; input_text[i]!='\0'; i++){
      char untrusted_char = input_text[i];
      

      if (untrusted_char >= 'a' && untrusted_char <= 'z')
          input_text[i] = ((input_text[i] - 'a') + shift_key) % MAX_ALPHABET + 'a';
    }
}

int
main() {
    unsigned int shift_key = 1;
    char greet[6] = "hello";
    cipher (greet, shift_key);
    printf ("[*]result: %s\n", greet );
    return 0;
}

/* don't do anything on non-lowercase Alphabetic characters
    if (untrusted_char >= 'a' && untrusted_char <= 'z')
*/
/*  dissecting this line:
    input_text[i] = ((input_text[i] - 'a') + shift_key) % MAX_ALPHABET + 'a';

    // Get position of char 'h' from start
    (lldb) po (input_text[i] - 'a')
    7
 
    // Get position from start + 1 ( the shift_key value )
    (lldb) po ((input_text[i] - 'a') + shift_key)
    8
 
    // Handle shift keys larger than 26
    (lldb) po ((input_text[i] - 'a') + shift_key) % 26;
    8

    // Re-add the int value of char 'a'
    (lldb) p/d 'a'
    (char) $4 = 97
 
    // final value of char
    (lldb) po ((input_text[i] - 'a') + shift_key) % 26 + 'a';
    105
 
    (lldb) p (char) 105
    (char) $14 = 'i'

*/

