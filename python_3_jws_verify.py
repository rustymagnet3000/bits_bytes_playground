```
#!/usr/bin/env python
from jwcrypto import jwk, jws, jwt

# https://jwcrypto.readthedocs.io/en/latest/jwk.html#examples
# https://jwcrypto.readthedocs.io/en/latest/jws.html#examples
# https://jwcrypto.readthedocs.io/en/latest/jwt.html

if __name__ == '__main__':

    try:
        print('\n' + ('*' * 20) + '\t\tEC Public Key \t\t' + ('*' * 20))
        coreRawJwk = {"kty":"EC","use":"sig","key_ops":["verify"],"kid":"631147f3-35c9-464a-9a7f-79b17f459f29","crv":"P-256","x":"D8LuO14B7huFBSVPnfHhLQJaE8d_wBr3gXHVgTc4Tn8","y":"sIf6SJTv6mNs08TRyW0iABT3OjvWkrfnPijk1SEM9gw"}
        key = jwk.JWK(**coreRawJwk)             # fakeKey = jwk.JWK()   pass in the empty key to trigger the exception
        print(key.export(private_key=False))

    except jwk.InvalidJWKType:
        print("[+] Invalid key")
        exit(99)

    try:
        print('\n' + ('*' * 20) + '\t\tJWS validation and partial Claim verify \t\t\t\t' + ('*' * 20))
        ET = jwt.JWT(key=key, jwt="eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IjYzMTE0N2YzLTM1YzktNDY0YS05YTdmLTc5YjE3ZjQ1OWYyOSJ9.eyJzZWNvbmQiOiJWYWRlciIsImlhdCI6MTU1NDI4ODA5MCwibmJmIjoxNTU0MjkxNjkwLCJ0aGlyZCI6IkRvb2t1IiwiZXhwIjoxNTU0MzI0MDkwLCJhdWQiOiJob3RoLWFwaSIsImZpcnN0IjoiU2lkaW91cyIsImlzcyI6Imh0dHBzOlwvXC9vdXRlcnJpbS5nYWxheHkifQ.4tEn0934UYkIYnKXlgLKuYsVy9RFVSyAii20RzAh_qE1V_Jas02YBkYSYGRAXDKbxbcKcHaIRRFof65IrWGZbw")
        print(ET.header)
        print(ET.claims)

    except jws.InvalidJWSSignature:
        print("[+] Signature invalid or key error")
    except jws.InvalidJWSObject:
        print("[+] invalid signature object")
    except jwt.JWTExpired:
        print("[+] JWT expired")
    except jwt.JWTMissingClaim:
        print("[+] JWT missing claim ")
    except jwt.JWTNotYetValid:
        print("[+] JWT not yet valid ")
    except jwt.JWTMissingKey:
        print("[+] missing key ")
    except:
        print("[+] unhandled error")
```
