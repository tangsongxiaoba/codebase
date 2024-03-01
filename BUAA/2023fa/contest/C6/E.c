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
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int arr[110];

int compare(const void *p1, const void *p2)
{
    int *a = (int *)p1;
    int *b = (int *)p2;
    if(*a > *b) return 1;
    else if(*a < *b) return -1;
    else return 0;
}

int lowerBound(const void *p1, const void *p2) {
    int *a = (int *)p1;
    int *b = (int *)p2;
    if ((b == arr || compare(a, b - 1) > 0) && compare(a, b) > 0) return 1;
    else if (b != arr && compare(a, b - 1) <= 0) return -1;
    else return 0;
}

int main() {
    int n, x, i;
    n = read();
    for(i = 0; i < n; ++i) {
        arr[i] = read();
    }
    qsort(arr, n, sizeof(int), compare);
    while(scanf("%d", &x) != EOF) {
        int *res = bsearch(&x, arr, n, sizeof(int), lowerBound);
        if(*res != x) puts("-1");
        else printf("%d\n", (int)(res-arr+1));
    }
    return 0;
}
