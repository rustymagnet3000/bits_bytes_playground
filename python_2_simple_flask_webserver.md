## Web Server
Connect from a real iOS device to a macOS machine over `https` on the same LAN.  Ensure `Flask` or `http.server` are listening on `all interfaces`, other only iOS Simulators will be able to hit your server.

You don't need to add new `Port Forwarding rules` when the web server was listening on all interfaces.

### Flask
##### Listen on all interfaces
```
HOST = '0.0.0.0'  # required to listen on all interfaces
app.run(host=HOST, port=SERVER_PORT, ssl_context=context, debug=True)
```
##### Specify your Cert Chain and Leaf's Private Key
```
def initialize_tls():
    global context
    context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
    context.load_cert_chain('certs/certchain.pem', 'certs/key.pem')  # .crt or .pem both works
```
### http.server
##### Listen on all interfaces
```
HOST = ''

def run(server_class=HTTPServer, handler_class=S):
    logging.basicConfig(level=logging.INFO)
    server_address = (HOST, PORT)
    httpd = server_class(server_address, handler_class)
```
##### Specify Cert Chain and Leaf's Private Key
```
if Path(CERT).is_file() and Path(KEY).is_file():
    print("[*] Found Cert Chain and Key file...")

httpd.socket = ssl.wrap_socket(httpd.socket, server_side=True, keyfile=KEY, certfile=CERT)
```
### Check Server is listening
##### with sudo
`sudo lsof -iTCP -sTCP:LISTEN -n -P`
##### without sudo
`netstat -anvp tcp | awk 'NR<3 || /LISTEN/'`
##### Result
```
COMMAND     PID     USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
Python    28360     root    3u  IPv4 0xa12c8333afeff20f      0t0  TCP *:8443 (LISTEN)
```
