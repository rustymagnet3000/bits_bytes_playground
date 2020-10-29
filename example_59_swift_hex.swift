import Foundation

let animal = "Baboon"

/* Create Unsigned Int array buffer         */
var buffer = [UInt8](animal.utf8)
print(buffer)
if let result = String(bytes: buffer, encoding: String.Encoding.ascii) {
    print(result)
}

let data = animal.data(using: String.Encoding.utf8)

/* Using NSData to print Hex String         */
print(data! as NSData)

/* map         */
let hex_string: String = buffer.map{ String(format:"%02x", $0) }.joined()
print(hex_string.reversed())
