## XOR Class
```
class XORme {
    let ptString: String
    let ptBytes: [UInt8]
    let key: [UInt8] = [65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65]
    lazy var ctBytes: [UInt8] = []

    convenience init(string: String) {
        let bytes = [UInt8](string.utf8)
        self.init(ptString: string, ptBytes: bytes)
    }

    init(ptString: String, ptBytes: [UInt8]) {
        self.ptString = ptString
        self.ptBytes = ptBytes
        var i = 0
        var ciphertxt = [UInt8]()
        for t in ptBytes {
            ciphertxt.append(t ^ key[i])
            i += 1
        }
        self.ctBytes = ciphertxt
        print ("\"\(ptString)\"\t\(ptBytes)")
        print ("Ciphertext\t\t\t\(ctBytes)")
    }
}

let a = XORme(string: "attack at dawn")
```
