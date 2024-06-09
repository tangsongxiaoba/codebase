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
    char s[13];
    int r, ord[13], final;
}stu[1010];

int a[13];

int compare(const void* x1, const void* x2) {
    struct node* p1 = (struct node*) x1;
    struct node* p2 = (struct node*) x2;
    if(p1->r > p2->r) return 1;
    else if(p1->r < p2->r) return -1;
    else return 0;
}

int main() {
    int i, j, n = read(), m = read();
    for(i = 1; i <= m; ++i) a[i] = read();
    for(i = 0; i < n; ++i) {
        scanf("%s", stu[i].s);
        stu[i].r = read();
        for(j = 1; j <= m; ++j) stu[i].ord[j] = read();
    }
    qsort(stu, n, sizeof(stu[0]), compare);
    for(i = 1; i <= m; ++i) {
        for(j = 0; j < n; ++j) {
            if(stu[j].final || !a[stu[j].ord[i]]) continue;
            stu[j].final = stu[j].ord[i];
            --a[stu[j].ord[i]];
        }
    }
    for(i = 0; i < n; ++i) {
        printf("%s %d\n", stu[i].s, stu[i].final);
    }
    return 0;
}
