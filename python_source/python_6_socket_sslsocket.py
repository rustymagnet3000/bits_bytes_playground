#!/usr/bin/env python3
from socket import socket
import ssl
# PROTOCOL_TLS_CLIENT requires valid cert chain and hostname
# Partial Chain flag let's a Root CA or Int CA validate the chain

hostname = 'google.com'
port = 443
with socket() as sock:
    sock.setblocking(True)
    sock.connect((hostname, port))
    context = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
    context.verify_flags = 0x80000
    context.load_verify_locations(cafile="google_int_ca.pem")
    with context.wrap_socket(sock=sock,
                             server_hostname=hostname,
                             do_handshake_on_connect=False) as ssl_sock:
        ssl_sock.settimeout(2.0)
        ssl_sock.do_handshake()
        print(ssl_sock.getpeername())
        print(ssl_sock.version())
        print(ssl_sock)

