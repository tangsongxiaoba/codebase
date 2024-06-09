#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define L 1000
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

typedef struct Node{
    int num;
    struct Node *child[3];
}node, *nodeptr;

nodeptr st[L];
int pos;

int cmp(const void *p1, const void *p2) {
    int *a = (int *) p1;
    int *b = (int *) p2;
    return a[1] == b[1] ? a[0] - b[0] : b[1] - a[1];
}

int main() {
    int fa, tot = 0;
    nodeptr R = (nodeptr)malloc(sizeof(node));
    R->num = 0;
    memset(R->child, 0, sizeof(R->child));
    while((fa = read()) != -1) {
        nodeptr p = (nodeptr)malloc(sizeof(node));
        p->num = fa;
        memset(p->child, 0, sizeof(p->child));
        int i = 0, ch;
        while((ch = read()) != -1) {
            p->child[i] = (nodeptr)malloc(sizeof(node));
            p->child[i]->num = ch;
            memset(p->child[i]->child, 0, sizeof(p->child[i]->child));
            ++i;
            if(ch < 100) ++tot;
        }
        if(R->num == 0) memcpy(R, p, sizeof(node));
        else
            for(int ii = 0; ii < pos; ++ii)
                if(st[ii]->num == p->num) {
                    memcpy(st[ii], p, sizeof(node));
                    break;
                }
        for(int ii = 0; ii < i; ++ii)
            if(p->child[ii]->num >= 100) st[pos++] = p->child[ii];
        free(p);
    }
    int num[100][2];
    for(int i = 0; i < tot; ++i) {
        num[i][0] = read();
        num[i][1] = read();
    }
    qsort(num, tot, sizeof(num[0]), cmp);
    int he = 0, re = -1;
    st[++re] = R;
    for(int i = 0; i < tot;) {
        nodeptr p = st[he];
        he = (he + 1) % L;
        for(int ii = 0; ii < 3; ++ii)
            if(p->child[ii] != NULL) {
                if(p->child[ii]->num >= 100) {
                    re = (re + 1) % L;
                    st[re] = p->child[ii];
                }
                else
                    printf("%d->%d\n", num[i++][0], p->child[ii]->num);
            }
    }
    return 0;
}
