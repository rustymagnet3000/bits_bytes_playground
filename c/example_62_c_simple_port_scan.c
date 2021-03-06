#include <stdio.h>
#include <sys/socket.h>
#include <errno.h>
#include <netdb.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#define HOSTNAME "127.0.0.1"
#define START 2200
#define END 2250
/*  https://docs.microsoft.com/en-us/previous-versions/aa454002(v=msdn.10)?redirectedfrom=MSDN   */

int main(int argc, char **argv){
    int result, sock;
    int refused_conns = 0, open_conns = 0, unknown_conns = 0;
    struct sockaddr_in sa = {0};

    sa.sin_family = AF_INET;
    sa.sin_addr.s_addr = inet_addr(HOSTNAME);

    puts("[*]scan started...");
    for( int i = START;  i <= END; i++ ){
        sa.sin_port = htons( i );
        sock = socket( AF_INET, SOCK_STREAM, 0 );
        result = connect( sock , ( struct sockaddr* ) &sa , sizeof sa );
        if ( result == 0 ) {
            printf( "[!]%i open port\n", i );
            open_conns++;
        }
        else if ( result == -1 ) {
            ( errno == 61 ) ? refused_conns++ : unknown_conns++ ;
        }
        close ( sock );
    }

    printf("[*]Completed.\n\tOpen ports: %d\tRefused ports:%d\tUnknown response:%d\n", open_conns, refused_conns, unknown_conns);
    return 0;
}

