/*
BUILD SCRIPT TO INJECT HASHED CERT VALUES INTO THE CAFILES DIRECTORY
echo "[*] c_rehash step for buiding Trust Store"
export CAFILES="${SYMROOT}/${CONFIGURATION}/cafiles/"

if [ -d "${CAFILES}" ] 
then
    echo "[*] Injecting symbolic links into CA directory"
    ${HOME}/openssl/bin/c_rehash ${CAFILES}
else
    echo "[*] Cannot find: ${CAFILES}"
    exit 999
fi
*/

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <dirent.h>
#include <unistd.h>

#include <openssl/bio.h>
#include <openssl/err.h>
#include <openssl/ssl.h>
#include <openssl/x509.h>
#include <openssl/x509_vfy.h>

#define HOSTANDPORT "127.0.0.1:8443"
#define BUFFER 1024
#define CAFILES "/cafiles/"

int main () {
    
    BIO *bio, *out;
    int len;
    char tmpbuf[BUFFER];
    char capath[PATH_MAX];
    SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
    SSL *ssl;
    DIR *dir;
    
    if (getcwd(capath, sizeof(capath)) == NULL)
        exit(100);

    strcat(capath, CAFILES);
    dir = opendir(capath);
    if (dir == NULL)
        exit(99);
    
    bio = BIO_new_ssl_connect(ctx);
    if(bio == NULL)
        exit(90);
    BIO_get_ssl(bio, & ssl);
    SSL_set_mode(ssl, SSL_MODE_AUTO_RETRY);
    
    BIO_set_conn_hostname(bio, HOSTANDPORT);
    
    out = BIO_new_fp(stdout, BIO_NOCLOSE);
    if (BIO_do_connect(bio) <= 0) {
        fprintf(stderr, "Error connecting to server\n");
        ERR_print_errors_fp(stderr);
        exit(91);
    }
    
    if(SSL_CTX_load_verify_locations(ctx, NULL, capath) == 0)
        exit(92);
    
    long result = SSL_get_verify_result(ssl);

    switch (result) {
        case X509_V_OK:
            fprintf(stdout, "Happy path\n");
            break;
        case X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY:
            fprintf(stderr, "Can't find certificate\n");
            exit(20);
        case X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN:
            fprintf(stdout, "Self signed certificate chain. Proceed\n");
            break;
        default:
            fprintf(stderr, "Unexpected error: %ld\n", result);
            exit((int)result);
    }

    BIO_puts(bio, "GET / HTTP/1.0\n\n");
    for ( ; ; ) {
        len = BIO_read(bio, tmpbuf, 1024);
        if (len <= 0)
            break;
        BIO_write(out, tmpbuf, len);
    }
    
    BIO_free(bio);
    BIO_free(out);
    SSL_CTX_free(ctx);
    ssl = NULL;
    return 0;
}
