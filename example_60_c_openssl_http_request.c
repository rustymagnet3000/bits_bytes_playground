/* https://www.openssl.org/docs/man1.1.0/man3/BIO_set_conn_hostname.html */

#include <openssl/bio.h>
#include <openssl/err.h>

int main (int argc, char *argv[])
{
    BIO *cbio, *out;
    int len;
    char tmpbuf[1024];

    cbio = BIO_new_connect("httpbin.org:80");
    out = BIO_new_fp(stdout, BIO_NOCLOSE);
    if (BIO_do_connect(cbio) <= 0) {
        fprintf(stderr, "Error connecting to server\n");
        ERR_print_errors_fp(stderr);
        exit(1);
    }
    BIO_puts(cbio, "GET / HTTP/1.0\n\n");
    for ( ; ; ) {
        len = BIO_read(cbio, tmpbuf, 1024);
        if (len <= 0)
            break;
        BIO_write(out, tmpbuf, len);
    }
    BIO_free(cbio);
    BIO_free(out);

    
    return 0;
}
