#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

struct Node{
    struct {
        char *word;
        int cnt;
    }dat;
    struct Node *left;
    struct Node *right;
};

typedef struct Node node, *nodeptr, *tree;

tree root;

void insert(char *key) {
    if(root->dat.word == NULL) {
        root->dat.word = (char *)malloc(sizeof(char) * strlen(key));
        strcpy(root->dat.word, key);
        root->dat.cnt = 1;
        return;
    }
    nodeptr ptr = root, pre;
    int flag = 0;
    while(ptr != NULL) {
        pre = ptr;
        if(strcmp(ptr->dat.word, key) > 0) ptr = ptr->left, flag = 0;
        else if(strcmp(ptr->dat.word, key) < 0) ptr = ptr->right, flag = 1;
        else {
            ++ptr->dat.cnt;
            return;
        }
    }
    nodeptr P = (nodeptr)malloc(sizeof(node));
    memset(P, 0, sizeof(node));
    P->dat.word = (char *)malloc(sizeof(char) * strlen(key));
    strcpy(P->dat.word, key);
    P->dat.cnt = 1;
    (flag == 1) ? (pre->right = P) : (pre->left = P);
}

void traversal(nodeptr p) {
    if(p->left != NULL) traversal(p->left);
    printf("%s %d\n", p->dat.word, p->dat.cnt);
    if(p->right != NULL) traversal(p->right);
}

int main() {
    freopen("article.txt", "r", stdin);
    char c;
    root = (tree)malloc(sizeof(node));
    memset(root, 0, sizeof(node));
    while((c = getchar()) != EOF) {
        if(isalpha(c)) {
            char s[100];
            int p = 0;
            do {
                s[p++] = tolower(c);
            } while(isalpha(c = getchar()));
            s[p] = '\0';
            insert(s);
        }
    }
    if(root->dat.word != NULL) printf("%s", root->dat.word);
    if(root->right != NULL) {
        printf(" %s", root->right->dat.word);
        if(root->right->right != NULL)
            printf(" %s", root->right->right->dat.word);
    }
    puts("");
    traversal(root);
    return 0;
}
