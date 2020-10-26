#include <stdio.h>
#include <sys/socket.h>
#include <errno.h>
#include <netdb.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/un.h>
#include <arpa/inet.h>
#define HOSTNAME "localhost"
#define PORT 60000

/*
    With TCP sockets, we had to establish a connection before we could communicate.
    With UDP, our sockets are connectionless. Hence, we can send messages immediately.
 
 https://www.gnu.org/software/libc/manual/html_node/Datagram-Example.html
 https://www.gta.ufrj.br/ensino/eel878/sockets/sendman.html
 */

int main(int argc, char **argv){
    struct hostent *hp;     /* host information */
    static const struct sockaddr_in zero_sockaddr_in;   /* different way to zero init our struct */
    struct sockaddr_in servaddr = zero_sockaddr_in;   /* server address */
    int fd_sock;
    char *sent_message = "Bob's message ( client )";
    ssize_t result = 0;
    
    /* server's address and data */
    memset ((char*)&servaddr, 0, sizeof (servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons (PORT);

    /* look server given name */
    hp = gethostbyname(HOSTNAME);
    if (!hp) {
        fprintf(stderr, "[!]could not obtain address of %s\n", HOSTNAME);
        exit (EXIT_FAILURE);
    }
    
    fd_sock = socket (AF_INET, SOCK_DGRAM, 0);
    if (fd_sock < 0)
      {
        perror ("[!]socket:");
        exit (EXIT_FAILURE);
      }

    /* put the host's address into the server address structure */
    memcpy ((void *)&servaddr.sin_addr, hp->h_addr_list[0], hp->h_length);

    char addr[INET_ADDRSTRLEN];
    uint16_t port;
    inet_ntop ( AF_INET, &servaddr.sin_addr, addr, sizeof (addr) );
    port = htons (servaddr.sin_port);
    printf("[*]scan started...\n[*]Server: %s:%d\n", addr, port );

    result = sendto (fd_sock, sent_message, strlen (sent_message), 0, (struct sockaddr *) & servaddr, sizeof (servaddr));
    
    if (result < 0)
        perror("sendto failed");

    char buffer[1024];
    socklen_t len;
    ssize_t n;
    
    n = recvfrom (fd_sock, (char *)buffer, 1024,
                    MSG_WAITALL, (struct sockaddr *) &servaddr,
                    &len);
    buffer[n] = '\0';
    printf("[*]Message from server : %s\n", buffer);
    
    /* Close a file descriptor */
    close (fd_sock);
    
    return 0;
}


