#!/usr/bin/env python3
from socket import socket
import ssl
# PROTOCOL_TLS_CLIENT requires valid cert chain and hostname
# Partial Chain flag let's a Root CA or Int CA validate the chain
# Requires the symbolic links to work
# > export CERTS=/path/to/ca_files
# > openssl/bin/c_rehash ${CERTS}

hostname = 'google.com'
port = 443
with socket() as sock:
    sock.setblocking(True)
    sock.connect((hostname, port))
    context = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
    context.verify_flags = 0x80000
    context.load_verify_locations(cafile=None,
                                  cadata=None,
                                  capath="/Users/a9006113/Coding/python_openssl_playground/support/ca_files/")
    with context.wrap_socket(sock=sock,
                             server_hostname=hostname,
                             do_handshake_on_connect=False) as ssl_sock:
        ssl_sock.settimeout(2.0)
        ssl_sock.do_handshake()
        print(hostname, ssl_sock.getpeername(), ssl_sock.version())
        print(ssl_sock)
