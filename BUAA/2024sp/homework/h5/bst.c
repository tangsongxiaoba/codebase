#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

struct node{
    int key;
    struct node *left;
    struct node *right;
    int height;
};

typedef struct node *Tree;
typedef struct node *Node;
typedef struct node TreeNode;

Tree Root;

void Insert(int key) {
    Node P = (Node)malloc(sizeof(TreeNode));
    Node ptr = Root, pre = Root;
    P->left = P->right = NULL;
    P->height = 1;
    P->key = key;
    int flag = 0;
    while(ptr != NULL) {
        pre = ptr;
        if(ptr->key > key) ptr = ptr->left, flag = 0;
        else ptr = ptr->right, flag = 1;
        ++(P->height);
    }
    (flag == 1) ? (pre->right = P) : (pre->left = P);
}
int main() {
    // freopen("in", "r", stdin);
    int n = read();
    Root = (Tree)malloc(sizeof(TreeNode));
    Root->left = Root->right = NULL;
    Root->height = 1;
    Root->key = read();
    for(int i = 1; i < n; ++i) Insert(read());
    Tree Stack[1<<8], ptr;
    int p = 0;
    Stack[p] = Root;
    while(p >= 0) {
        ptr = Stack[p--];
        if(ptr->left == NULL && ptr->right == NULL) {
            printf("%d %d\n", ptr->key, ptr->height);
        }
        if(ptr->right != NULL) {
            Stack[++p] = ptr->right;
        }
        if(ptr->left != NULL) {
            Stack[++p] = ptr->left;
        }
    }
    return 0;
}
