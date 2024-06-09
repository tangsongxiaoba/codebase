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

typedef struct{
    int pos;
    int len;
}dat;

typedef struct Node{
    dat chunk;
    struct Node *nxt;
    struct Node *pre;
}*list, *node;

void Insert(int pos, int len, node Pre) {
    node ptr = (node)malloc(sizeof(struct Node));
    ptr->chunk.pos = pos;
    ptr->chunk.len = len;
    ptr->nxt = Pre->nxt;
    if(Pre->nxt != NULL) Pre->nxt->pre = ptr;
    ptr->pre = Pre;
    Pre->nxt = ptr;
}

void Delete(node P) {
    node pre = P->pre;
    node tmp = pre->nxt;
    pre->nxt = tmp->nxt;
    if(tmp->nxt != NULL) tmp->nxt->pre = pre;
    free(tmp);
}

void PrintList(list L) {
    node P = L;
    do {
        P = P->nxt;
        if(P == L) continue; 
        printf("%d %d\n", P->chunk.pos, P->chunk.len);
    } while(P != L);
}

int main() {
    // freopen("in", "r", stdin);
    int cnt = read();
    list L = (list)malloc(sizeof(struct Node));
    L->nxt = L->pre = NULL;
    L->chunk.len = L->chunk.pos = -1;
    node P = L;
    for(int i = 1; i <= cnt; ++i) {
        int pos = read(), len = read();
        Insert(pos, len, P);
        P = P->nxt;
    }
    L->pre = P;
    P->nxt = L;
    P = L->nxt;
    int ask;
    while((ask = read()) != -1) {
        node p = P, tmp;
        int len = -1;
        do{
            if(p == L) {
                p = p->nxt;
                continue;
            }
            if(p->chunk.len >= ask) {
                if(p->chunk.len < len || len == -1) {
                    tmp = p;
                    len = tmp->chunk.len;
                }
            }
            p = p->nxt;
        }while(p != P);
        if(len != -1) {
            if(len == ask) {
                P = tmp->nxt;
                Delete(tmp);
            }
            else {
                P = tmp;
                tmp->chunk.len -= ask;
            }
        }
        // printf("%d %d\n", P->chunk.pos, P->chunk.len);
        // PrintList(L);
        // puts("");
    }
    node p = P;
    do {
        if(p == L) {
            p = p->nxt;
            continue;
        }
        printf("%d %d\n", p->chunk.pos, p->chunk.len);
        p = p->nxt;
    }while(p != P);
    return 0;
}
