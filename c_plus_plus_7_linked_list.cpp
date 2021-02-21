#include <iostream>

using namespace std;

class YDNode final {
    string name;
    YDNode *next;
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
                cout << "Tail: \t" << node->name << "\n";
            else
                cout << "Node: \t" << node->name << "\n";

            node = node->next;
        }
    }

    static void deleteNode(YDNode *node_to_delete) {

        if (head == NULL) {
            cout << "empty list";
            return;
        }

        if (node_to_delete == head) {                   // Deleting item at Head of list
            if (head->next == NULL){                    // Only a single item in Linked List
                head = NULL;
                delete node_to_delete;
                return;
            }
            else {                                      // Deleting Head but N items in list
                head = head->next;
                delete node_to_delete;
                return;
            }
        }

        YDNode *node = head;
        while (node != NULL) {
            if (node->next == node_to_delete)
            {
                cout << "Found node to delete: \t" << node_to_delete->name << "\n";
                node->next = node_to_delete->next;
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
    this->next = head;
    head = this;
}

inline YDNode::YDNode(string name, YDNode *previous_node)
{
    this->name = name;
    this->next = previous_node->next;
    previous_node->next = this;
}


int main(int argc, const char * argv[]) {

    /* add to Head */
    YDNode *node_a = new YDNode("Wandering");
    YDNode *node_b = new YDNode("Wolf");
    YDNode *node_c = new YDNode("Camel");

    /* Insert after */
    YDNode *node_d = new YDNode("Red back", node_c);
    YDNode *node_e = new YDNode("Shelob", node_c);
    YDNode *node_f = new YDNode("Harvestman", node_e);
    YDNode *node_z = new YDNode("odd", node_f);

    /* Pretty Print */
    YDNode::prettyPrint();

    /* Find */
    string spider = "Wolf";
    YDNode::findValue(spider);
    YDNode::findValue("dog");

    /* Delete and Print */
    YDNode::deleteNode(node_b);
    YDNode::deleteNode(node_c);

    YDNode::prettyPrint();
    YDNode::deleteNode(node_d); // tail
    YDNode::prettyPrint();
    YDNode::deleteNode(node_a); // head
    YDNode::prettyPrint();
    YDNode::deleteNode(node_e); // head
    YDNode::deleteNode(node_f); // head
    YDNode::prettyPrint();
    return 0;

}
