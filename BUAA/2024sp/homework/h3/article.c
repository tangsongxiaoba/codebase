#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

char txt[100];
typedef struct Node{
    char *dat;
    int cnt;
    struct Node *nxt;
}*list, *node;

void read() {
    register int x = 0, p = 0;
    register char c = getchar();
    while(!isalpha(c) && c != -1) c = getchar();
    while(isalpha(c)) txt[p++] = tolower(c), c = getchar();
    txt[p] = 0;
}

void Insert(list L) {
    node P = L;
    while(P->nxt != NULL) {
        if(strcmp(P->nxt->dat, txt) > 0) break;
        else if(strcmp(P->dat, txt) < 0) P = P->nxt;
    }
    if(strcmp(P->dat, txt) == 0) P->cnt += 1;
    else {
        node p = (node)malloc(sizeof(struct Node));
        p->cnt = 1;
        p->dat = (char*)malloc((strlen(txt)+1) * sizeof(char));
        strcpy(p->dat, txt);
        p->nxt = P->nxt;
        P->nxt = p;
    }
}

int main() {
    freopen("article.txt", "r", stdin);
    list L = (list)malloc(sizeof(struct Node));
    L->cnt = 0;
    L->dat = (char*)malloc(sizeof(char));
    *(L->dat) = '\0';
    L->nxt = NULL;
    do {
        read();
        Insert(L);
    }while(txt[0] != '\0');
    node P = L->nxt;
    while(P != NULL) {
        if(P->cnt) {
            printf("%s %d\n", P->dat, P->cnt);
        }
        P = P->nxt;
    }
    return 0;
}
