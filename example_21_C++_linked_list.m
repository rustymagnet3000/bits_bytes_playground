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
                node_to_delete->~YDNode();
                return;
            }
            else {                                      // Deleting Head but N items in list
                head = head->next;
                node_to_delete->~YDNode();
                return;
            }
        }

        YDNode *node = head;
        while (node != NULL) {
            if (node->next == node_to_delete)
            {
                cout << "Found node to delete: \t" << node_to_delete->name << "\n";
                node->next = node_to_delete->next;
                node_to_delete->~YDNode();
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
    YDNode node_a = YDNode("Wandering");
    YDNode node_b = YDNode("Wolf");
    YDNode node_c = YDNode("Camel");

    /* Insert after */
    YDNode node_d = YDNode("Red back", &node_c);
    YDNode node_e = YDNode("Shelob", &node_c);
    YDNode node_f = YDNode("Harvestman", &node_e);

    /* Pretty Print */
    YDNode::prettyPrint();

    /* Find */
    string spider = "Wolf";
    YDNode::findValue(spider);
    YDNode::findValue("dog");

    /* Delete and Print */
    YDNode::deleteNode(&node_b);
    YDNode::deleteNode(&node_a);

    YDNode::prettyPrint();
    YDNode::deleteNode(&node_d); // tail
    YDNode::prettyPrint();
    YDNode::deleteNode(&node_c); // head
    YDNode::prettyPrint();
    YDNode::deleteNode(&node_e); // head
    YDNode::deleteNode(&node_f); // head
    YDNode::prettyPrint();
    return 0;

}
