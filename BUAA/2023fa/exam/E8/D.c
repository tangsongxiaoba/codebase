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
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
    putchar(' ');
}

int a[1000100];

int compare(const void* x1, const void* x2) {
    int* p1 = (int*) x1;
    int* p2 = (int*) x2;
    if(*p1 > *p2) return 1;
    else if(*p1 < *p2) return -1;
    else return 0;
}

int main() {
    int i, n = read(), k = read();
    for(i = 0; i < n; ++i) {
        a[i] = read();
    }
    qsort(a, n, sizeof(int), compare);
    for(i = 0; i < k; ++i) write(a[i]);
    return 0;
}
