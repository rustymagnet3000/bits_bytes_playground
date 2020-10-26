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
#define START 2200
#define END 2600

/*
    With TCP sockets, we had to establish a connection before we could communicate.
    With UDP, our sockets are connectionless. Hence, we can send messages immediately.
 
 https://www.gnu.org/software/libc/manual/html_node/Datagram-Example.html
 https://www.gta.ufrj.br/ensino/eel878/sockets/sendman.html
 */

/* paddr: print the IP address in a standard decimal dotted format */
void paddr(unsigned char *a)
{
        printf("Host: %d.%d.%d.%d\n", a[0], a[1], a[2], a[3]);
}


int main(int argc, char **argv){
    struct hostent *hp;     /* host information */
    static const struct sockaddr_in zero_sockaddr_in;   /* different way to zero init our struct */
    struct sockaddr_in servaddr = zero_sockaddr_in;   /* server address */
    int fd_socket;
    char *sent_message = "Foobar message";

    /* server's address and data */
    memset((char*)&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(2222);

    /* look server given name */
    hp = gethostbyname(HOSTNAME);
    if (!hp) {
            fprintf(stderr, "could not obtain address of %s\n", HOSTNAME);
            return 0;
    }
    
    fd_socket = socket (PF_LOCAL, SOCK_DGRAM, 0);
    if (fd_socket < 0)
      {
        perror ("socket");
        exit (EXIT_FAILURE);
      }

    /* print address of hostname */
    for (int i=0; hp->h_addr_list[i] != 0; i++)
            paddr((unsigned char*) hp->h_addr_list[i]);
    

    /* put the host's address into the server address structure */
    memcpy ((void *)&servaddr.sin_addr, hp->h_addr_list[0], hp->h_length);

    
    puts ("[*]scan started...");

    if ( sendto(fd_socket, sent_message, strlen(sent_message), 0, (struct sockaddr *) & servaddr, sizeof(servaddr)) < 0 ) {
        perror("sendto failed");
        return 0;
    }

    /* Why close UDP?  https://www.cs.rutgers.edu/~pxk/417/notes/sockets/udp.html */
    close(fd_socket);
    
    return 0;
}
