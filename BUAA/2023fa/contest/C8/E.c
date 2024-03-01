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

int popcount(int x) {
    int cnt = 0;
    while(x) {
        cnt++;
        x -= x & -x;
    }
    return cnt;
}

struct node{
    int x, e;
}a[100010];

int compare_node(const void *p1, const void *p2) {
    struct node *a = (struct node *)p1;
    struct node *b = (struct node *)p2;
    if(a->e > b->e) return 1;
    else if(a->e < b->e) return -1;
    else {
        if(a->x > b->x) return -1;
        else if(a->x < b->x) return 1;
        else return 0;
    }
}

void print(int x) {
    int i;
    for(i = 31; i >= 0; --i) {
        putchar(((x >> i) & 1) + '0');
    }
    puts("");
}

int main() {
    int i, n = read();
    for(i = 0; i < n; ++i) {
        a[i].x = read();
        a[i].e = popcount(a[i].x);
    }
    qsort(a, n, sizeof(struct node), compare_node);
    for(i = 0; i < n; ++i) {
        printf("%11d %2d ", a[i].x, a[i].e);
        print(a[i].x);
    }
    return 0;
}
