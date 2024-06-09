#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

typedef struct {
    int co, deg;
}dat;

typedef struct Node {
    dat term;
    struct Node *nxt;
    struct Node *pre;
}*list, *node;

void Insert(int co, int deg, node Pre) {
    node ptr = (node)malloc(sizeof(struct Node));
    ptr->term.co = co;
    ptr->term.deg = deg;
    ptr->nxt = Pre->nxt;
    if(Pre->nxt != NULL) Pre->nxt->pre = ptr;
    ptr->pre = Pre;
    Pre->nxt = ptr;
}

node Last(list L) {
    node P = L;
    while(P->nxt != NULL) P = P->nxt;
    return P;
}

int main() {
    // freopen("multi.in", "r", stdin);
    char s[50];
    list L[2];
    for(int j = 0; j < 2; ++j) {
        L[j] = (list)malloc(sizeof(struct Node));
        L[j]->term.co = L[j]->term.deg = -1;
        L[j]->nxt = L[j]->pre = NULL;
        fgets(s, 50, stdin);
        int co, deg;
        char *p = s+strlen(s);
        node pTr = L[j];
        while(p != s) {
            while(!isdigit(*p) && p-s >= 0) --p;
            for(int i = 0; i < 2; ++i) {
                while(isdigit(*p) && p-s >= 0) --p;
                --p;
            }
            ++p; ++p;
            sscanf(p, "%d%d", &co, &deg);
            Insert(co, deg, pTr);
            pTr = pTr->nxt;
            if(p-s > 0)--p;
        }
    }
    list Res = (list)malloc(sizeof(struct Node));
    Res->nxt = Res->pre = NULL;
    for(node p1 = L[0]; p1->nxt != NULL; p1 = p1->nxt) {
        for(node p2 = L[1]; p2->nxt != NULL; p2 = p2->nxt) {
            int co = p1->nxt->term.co * p2->nxt->term.co;
            int deg = p1->nxt->term.deg + p2->nxt->term.deg;
            node p3 = Res;
            while(p3->nxt != NULL && p3->nxt->term.deg < deg) p3 = p3->nxt;
            if(p3->nxt != NULL && p3->nxt->term.deg == deg) p3->nxt->term.co += co;
            else {
                Insert(co, deg, p3);
            }
        }
    }
    node p = Last(Res);
    while(p != Res) {
        printf("%d %d ", p->term.co, p->term.deg);
        p = p->pre;
    }
    return 0;
}
