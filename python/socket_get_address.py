import socket

addrInfo = socket.getaddrinfo("google.co.uk", 443)
print(addrInfo)
