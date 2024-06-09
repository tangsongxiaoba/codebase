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
    long long x, e;
}f[100010], g[100010], k[200010];

int q[200010], p;

int compare(const void *p1, const void *p2) {
    int *a = (int *)p1;
    int *b = (int *)p2;
    if(*a > *b) return -1;
    else if(*a < *b) return 1;
    else return 0;
}

int compare_node(const void *p1, const void *p2) {
    struct node *a = (struct node *)p1;
    struct node *b = (struct node *)p2;
    if(a->e > b->e) return -1;
    else if(a->e < b->e) return 1;
    else return 0;
}

int main() {
    int n = read(), m = read();
    int i, j, a, b;
    for(i = 0; i < n; ++i) {
        f[i].x = read();
        f[i].e = read();
        q[p++] = f[i].e;
    }
    for(i = 0; i < m; ++i) {
        g[i].x = read();
        g[i].e = read();
        q[p++] = g[i].e;
    }
    qsort(f, n, sizeof(struct node), compare_node);
    qsort(g, m, sizeof(struct node), compare_node);
    qsort(q, p, sizeof(int), compare);
    for(i = 0, j = 0, a = 0, b = 0; i < m+n; ++i) {
        if(a >= n && b >= m) break;
        if(j > 0 && q[j-1] == q[j] && q[j] == 0) break;
        if(j > 0) while(q[j] == q[j-1] && j < p) ++j;
        k[i].e = q[j];
        while(f[a].e > q[j] && a < n) ++a;
        while(g[b].e > q[j] && b < m) ++b;
        if(f[a].e == q[j]) k[i].x += f[a].x;
        if(g[b].e == q[j]) k[i].x += g[b].x;
        ++j;
    }
    for(i = 0; i < m+n; ++i) {
        if(k[i].x == 0) continue;
        printf("%lld %lld ", k[i].x, k[i].e);
    }
    return 0;
}
