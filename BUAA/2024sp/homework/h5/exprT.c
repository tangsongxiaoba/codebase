#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

enum op{plu = '+', min = '-', mul = '*', divv = '/'};

bool isOp(enum op c) {
    return (c == plu || c == min || c == mul || c == divv) ? true : false;
}

typedef struct{
    bool type; //false if num, true if ch
    union{
        int num;
        char ch;
    };
}dat;

void print(dat x) {
    if(x.type == false) {
        printf("%d", x.num);
    }
    else putchar(x.ch);
}

struct node{
    dat d;
    int res;
    struct node *l, *r;
};

typedef struct node *Node, TreeNode;

Node Stack[1<<8];
int p;

int prio(char op) {
    if(op == '(') return 1;
    if(op == '+' || op == '-') return 2;
    if(op == '*' || op == '/') return 3;
    return -1;
}

void toPostfix(char s[]) {
    int p = 0, j = 0;
    char st[1<<8] = "";
    for(int i = 0; s[i] != '=';) {
        if(s[i] == ' ') {
            ++i;
            continue;
        }
        if(s[i] == '(') {
            st[++j] = s[i++];
        }
        else if(s[i] == ')') {
            while(st[j] != '(' && j > 0) {
                s[p++] = st[j--];
            }
            if(j > 0) --j;
            ++i;
        }
        if(isdigit(s[i])) {
            while(isdigit(s[i])) s[p++] = s[i++];
            s[p++] = ' ';
        }
        else if(isOp(s[i])) {
            while(prio(s[i]) <= prio(st[j]) && j > 0) {
                s[p++] = st[j--];
            }
            st[++j] = s[i++];
        }
    }
    while(j > 0) s[p++] = st[j--];
    s[p] = '=';
    s[++p] = '\0';
    // puts(s);
}

int main() {
    // freopen("in", "r", stdin);
    char buf[1<<16];
    fread(buf, sizeof(char), 1<<16, stdin);
    toPostfix(buf);
    // while(1);
    for(int i = 0; buf[i] != '=';) {
        if(buf[i] == ' ') {
            ++i;
            continue;
        }
        Node tmp = (Node)malloc(sizeof(TreeNode));
        tmp->l = tmp->r = NULL;
        if(isdigit(buf[i])) {
            tmp->d.type = 0;
            tmp->d.num = 0;
            do{
                tmp->d.num = tmp->d.num * 10 + buf[i] - '0';
                ++i;
            }while(isdigit(buf[i]));
            tmp->res = tmp->d.num;
            Stack[++p] = tmp;
        }
        else if(isOp(buf[i])){
            tmp->d.type = 1;
            tmp->r = Stack[p--];
            tmp->l = Stack[p--];
            tmp->d.ch = buf[i]; 
            switch((enum op)buf[i]) {
                case plu: 
                    tmp->res = tmp->l->res + tmp->r->res;
                    break;
                case min: 
                    tmp->res = tmp->l->res - tmp->r->res;
                    break;
                case mul:
                    tmp->res = tmp->l->res * tmp->r->res;     
                    break;
                case divv:
                    tmp->res = tmp->l->res / tmp->r->res;
                    break;
            }
            Stack[++p] = tmp;
            ++i;
        }
    }
    print(Stack[p]->d); putchar(' ');
    if(Stack[p]->l != NULL) print(Stack[p]->l->d), putchar(' ');
    if(Stack[p]->r != NULL) print(Stack[p]->r->d), putchar('\n');
    printf("%d", Stack[p]->res);
    return 0;
}
