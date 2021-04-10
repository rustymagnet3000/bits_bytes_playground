class CertNode:
    def __init__(self, result, depth, common_name):
        self.common_name = common_name
        self.result = result
        self.depth = depth
        self.next_val = None


class SinglyLinkedList:
    def __init__(self):
        self.head_val = None

# Add new node
    def at_end(self, new_cert: CertNode):
        if self.head_val is None:
            self.head_val = new_cert
            return
        last_entry = self.head_val
        while last_entry.next_val:
            last_entry = last_entry.next_val
        last_entry.next_val = new_cert

# Print the linked list
    def pretty_print(self):
        cert = self.head_val
        while cert is not None:
            print('[*] {0}|{2}|\t\t{1}'.format(cert.result, cert.common_name, cert.depth))
            cert = cert.next_val


# List of Singly Linked Lists, for each hostname
if __name__ == '__main__':
    ll = SinglyLinkedList()
    ll.head_val = CertNode('pass', 1, '*.stackexchange.com')
    leaf = CertNode('pass', 0, 'httpbin.org')
    int_ca_1 = CertNode('pass', 1, 'Amazon')
    int_ca_2 = CertNode('pass', 1, 'Let\'s Encrypt Authority X3')
    ll.at_end(leaf)
    ll.at_end(int_ca_1)
    ll.at_end(int_ca_2)
    ll.pretty_print()



[*] pass|1|		*.stackexchange.com
[*] pass|0|		httpbin.org
[*] pass|1|		Amazon
[*] pass|1|		Let's Encrypt Authority X3
