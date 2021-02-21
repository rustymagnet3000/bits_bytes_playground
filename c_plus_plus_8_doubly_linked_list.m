#include <iostream>
#define MAX_SPIDERS 8

/****************************************************/
/*********         Doubly Linked List       *********/
/****************************************************/

using namespace std;

class YDNode final {
    string name;
    YDNode *next;
    YDNode *prev;
    static YDNode *head;
public:
    YDNode(string name);
    YDNode(string name, YDNode *previous_node);

    static void prettyPrint(void) {
        cout << string(40, '*') << endl;
        if (head == NULL) {
            cout << "empty list" << endl;
            return;
        }
        cout << "Head: \t" << head->name << "\n";
        YDNode *node = head->next;
        while (node != NULL) {
            if (node->next == NULL)
                cout << "Tail: \t" << node->name << "\n\t\t\tPrevious:" << node->prev->name << endl;
            else
                cout << "Node: \t" << node->name << "\n\t\t\tPrevious:" << node->prev->name << "\tNext:" << node->next->name  << endl;

            node = node->next;
        }
    }

    static void deleteNode(YDNode *node_to_delete) {

        if (head == NULL) {
            cout << "empty list";
            return;
        }

        if (node_to_delete == head) {                // Deleting item at Head of list
            if (head->next == NULL)                  // Only a single item in Linked List
                head = NULL;
            else                                     // Deleting Head but N items in list
                head = head->next;

            cout << "Node to delete is Head: \t" << node_to_delete->name << endl;
            delete node_to_delete;
            return;
        }

        YDNode *node = head;
        while (node != NULL) {
            if (node->next == node_to_delete)
            {
                if (node_to_delete->next == NULL){
                    cout << "Node to delete is Tail: \t" << node_to_delete->name << endl;
                    node->next = NULL;
                }
                else {
                    cout << "Found node to delete: \t" << node_to_delete->name << "\n";
                    node_to_delete->next->prev = node_to_delete->prev;           // point subsequent node to previous node
                    node->next = node_to_delete->next;
                }
                delete node_to_delete;
                return;
            }
            node = node->next;
        }
    }

    static void findValue(string name) {
        YDNode *node = head->next;
        while (node != NULL) {
            if (node->name == name)
            {
                cout << "Found:\t" << node->name  << " @ " << node << "\n";
                return;
            }
            node = node->next;
        }
        cout << "NOT Found: " << name << "\n";
    }

};

YDNode* YDNode::head = NULL;

/* insert at Head */
inline YDNode::YDNode(string name)
{
    this->name = name;
    this->prev = NULL;
    this->next = head;
    if (head != NULL)
        this->next->prev = this;
    head = this;

}

/* insert after */
inline YDNode::YDNode(string name, YDNode *previous_node)
{
    this->name = name;
    this->next = previous_node->next;
    previous_node->next->prev = this;
    this->prev = previous_node;
    previous_node->next = this;
}


int main(int argc, const char * argv[]) {

    /* add to Head */
    YDNode *node_a = new YDNode("Wandering");
    YDNode *node_b = new YDNode("Wolf");
    YDNode *node_c = new YDNode("Camel");
    YDNode *node_d = new YDNode("Dune");

    /* Insert after */
    YDNode *node_m = new YDNode("Moustache", node_c);
    YDNode *node_r = new YDNode("Harvestman", node_c);
    YDNode *node_s = new YDNode("Shelob", node_c);
    YDNode *node_t = new YDNode("Trapdoor", node_c);

    YDNode::deleteNode(node_b);     // regular delete
    YDNode::deleteNode(node_c);
    YDNode::prettyPrint();

    YDNode::deleteNode(node_d);     // delete Head
    YDNode::deleteNode(node_t);
    YDNode::prettyPrint();

    YDNode::deleteNode(node_a);     // delete Tail
    YDNode::deleteNode(node_m);
    YDNode::prettyPrint();

    YDNode::deleteNode(node_r);     // delete all
    YDNode::deleteNode(node_s);
    YDNode::prettyPrint();
    return 0;

}
