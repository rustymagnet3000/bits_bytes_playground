#!/usr/bin/env python3
# ----------------------------------------------------
# ---> remember to run c_rehash in folder of certs <-- 
# ----------------------------------------------------
from socket import (
    socket, getaddrinfo, AF_INET, SOCK_STREAM, IPPROTO_TCP
)
import datetime
from OpenSSL.crypto import X509
from texttable import Texttable
from OpenSSL.SSL import (
    Connection,
    TLSv1_2_METHOD,
    OP_NO_SSLv2,
    OP_NO_SSLv3,
    OP_NO_TLSv1,
    Context,
    VERIFY_PEER
)


class YDSocket:
    table = Texttable()
    table.set_cols_width([50, 10, 30])
    table.set_deco(table.BORDER | Texttable.HEADER | Texttable.VLINES)
    open_sockets = 0
    bad_sockets = 0
    port = 443

    def __init__(self, host):
        self.host = host
        self.sock = socket(AF_INET, SOCK_STREAM)

    def __enter__(self):
        """
            The getaddrinfo() call throw a GAI Error, if bad hostname
            The connect() can throw
        :return: self
        """
        self.sock.setblocking(True)
        getaddrinfo(self.host, YDSocket.port, proto=IPPROTO_TCP)
        self.sock.connect((self.host, YDSocket.port))
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.sock.close()

    @staticmethod
    def print_all_connections():
        YDSocket.table.header(['Hostnames', 'result', 'Good {0} / Bad {1} '.format(YDSocket.open_sockets,
                                                                                   YDSocket.bad_sockets)])
        print("\n" + YDSocket.table.draw() + "\n")


class YDClient:
    def __init__(self, host, sock, path_to_ca_certs):
        print("__init__ called")
        self.host = bytes(host, 'utf-8')
        self.port = 443
        self.sock = sock
        self.truststore_path = path_to_ca_certs

    def __enter__(self):
        print("__enter__ called")
        self.tls_client = Connection(YDClient.get_context(self.truststore_path), self.sock)
        self.tls_client.set_tlsext_host_name(self.host)             # Ensures ServerName when Verify() callbacks
        self.tls_client.set_connect_state()                         # set to work in client mode
        self.tls_client.do_handshake()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("exit called")

    @staticmethod
    def get_context(path_to_ca_certs):
        """
            Sets and returns an OpenSSL.context. Notice it sets a flag ont the Cert Store associated to the Context
        """
        context = Context(TLSv1_2_METHOD)
        verify_flags = 0x80000  # partial Chain allowed
        context.set_timeout(3)
        context.set_options(OP_NO_SSLv2 | OP_NO_SSLv3 | OP_NO_TLSv1)
        context.get_cert_store().set_flags(verify_flags)
        context.load_verify_locations(cafile=None, capath=bytes(path_to_ca_certs, 'utf-8'))
        context.set_verify(VERIFY_PEER, YDClient.verify_cb)
        return context

    @staticmethod
    def verify_cb(conn, cert, err_num, depth, ok):
        """
        Only works if c_rehash has previously inserted the symlinks into the CA Path directory
        :param ok:
        :return:
        """
        return ok

    @staticmethod
    def print_cert_info(cert: X509):
        s = '''
         commonName: {commonname}
         issuer: {issuer}
         notBefore: {notbefore}
         notAfter:  {notafter}
         serial num: {serial_number}
         Expired: {expired}
         '''.format(
            commonname=cert.get_subject().CN,
            issuer=cert.get_issuer().CN,
            notbefore=YDClient.pretty_date(cert.get_notBefore()),
            notafter=YDClient.pretty_date(cert.get_notAfter()),
            serial_number=cert.get_serial_number(),
            expired=cert.has_expired()
        )
        print(s)

    @staticmethod
    def pretty_date(date_from_cert: bytes):
        date = (datetime.datetime.strptime(date_from_cert.decode('ascii'), '%Y%m%d%H%M%SZ'))
        return(f"{date:%d-%b-%Y}")


if __name__ == "__main__":

    hostnames = ["httpbin.org", "github.com", "google.com"]

    for host in hostnames:
        with YDSocket(host) as s:
            YDSocket.table.add_row([host, 'connected', s.sock.getpeername()])
            with YDClient(host, s.sock, "path/to/ca_files") as client:
                cert_chain = client.tls_client.get_peer_cert_chain()
                for cert in cert_chain:
                    YDClient.print_cert_info(cert)

    YDSocket.print_all_connections()


