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

typedef struct node {
    int x, y;
}point;

typedef struct Node {
    point p1, p2;
    struct Node *nxt;
}*list;

typedef struct NOde{
    list head;
    int cnt;
}group;

group g[110];
int pos;

void InsertLine(point p1, point p2, list p) {
    list pnxt = malloc(sizeof(struct Node));
    pnxt->p1 = p1, pnxt->p2 = p2;
    pnxt->nxt = p->nxt;
    p->nxt = pnxt;
}

list FindPrev(list p, list L) {
    list ptr = L;
    while(ptr->nxt != p) ptr = ptr->nxt;
    return ptr;
}

list FindLast(list L) {
    list ptr = L;
    while(ptr->nxt != NULL) ptr = ptr->nxt;
    return ptr;
}

int main() {
    // freopen("line.in", "r", stdin);
    int n = read();
    point p1, p2, p3, p4;
    for(int i = 1; i <= n; ++i) {
        p1.x = read(), p1.y = read();
        p2.x = read(), p2.y = read();
        for(int j = 0; j <= pos; ++j) {
            if(g[j].cnt == 0) {
                g[j].head = malloc(sizeof(struct Node));
                g[j].head->nxt = NULL;
                InsertLine(p1, p2, g[j].head);
                ++g[j].cnt;
                ++pos;
                break;
            }
            list ptr = g[j].head;
            int flag = 0;
            while(ptr->nxt != NULL) {
                ptr = ptr->nxt;
                if(ptr->p1.x == p2.x && ptr->p1.y == p2.y) {
                    ptr = FindPrev(ptr, g[j].head);
                    InsertLine(p1, p2, ptr);
                    ++g[j].cnt;
                    flag = 1;
                    break;
                }
                else if(ptr->p2.x == p1.x && ptr->p2.y == p1.y) {
                    InsertLine(p1, p2, ptr);
                    ++g[j].cnt;
                    flag = 1;
                    break;
                }
            }
            if(flag == 1) break;
        }
    }
    for(int i = 0; i < pos; ++i) {
        if(g[i].cnt == 0) continue;
        p1 = g[i].head->nxt->p1, p2 = FindLast(g[i].head)->p2;
        for(int j = 0; j < pos; ++j) {
            if(j == i || g[j].cnt == 0) continue;
            p3 = g[j].head->nxt->p1;
            p4 = FindLast(g[j].head)->p2;
            if(p3.x == p2.x && p3.y == p2.y) {
                g[i].cnt += g[j].cnt, g[j].cnt = 0;
                FindLast(g[i].head)->nxt = g[j].head->nxt;
            }
            else if(p4.x == p1.x && p4.y == p1.y) {
                g[i].cnt += g[j].cnt, g[j].cnt = 0;
                FindLast(g[j].head)->nxt = g[i].head->nxt;
                g[i].head->nxt = g[j].head->nxt;
            }
        }
    }
    int id = 0;
    for(int j = 0; j < pos; ++j) {
        if(g[j].cnt > g[id].cnt) id = j;
    }
    write(g[id].cnt); putchar(' ');
    write(g[id].head->nxt->p1.x); 
    putchar(' '); 
    write(g[id].head->nxt->p1.y);
    return 0;
}
