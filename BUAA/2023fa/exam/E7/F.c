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
}

int a[1000100];

int compare(const void* p1, const void* p2) {
    int* a = (int*)p1;
    int* b = (int*)p2;
    if(*a > *b) return 1;
    else if(*a < *b) return -1;
    else return 0;
}

int lowerBound(int key, int arr[], int start, int end) {
    int mid;
    while (start < end) {
        mid = (start + end) >> 1;
        if (arr[mid] >= key)
            end = mid - 1;
        else start = mid + 1;
    }
    return arr[start] >= key ? start : start+1;
}

int upperBound(int key, int arr[], int start,int end) {
    int mid;
    while (start < end) {
        mid = (start + end) >> 1;
        if (arr[mid] > key)
            end = mid-1;
        else start = mid+1;
    }
    return arr[end] <= key ? end+1 : end;
}

int main() {
    int i, key, n = read(), t = read();
    for(i = 0; i < n; ++i) {
        a[i] = read();
    }
    for(i = 1; i <= t; ++i) {
        key = read();
        int* res = bsearch(&key, a, n, sizeof(int), compare);
        if(res == NULL) puts("-1");
        else {
            int p1 = lowerBound(key, a, 0, n-1);
            int p2 = upperBound(key, a, p1, n-1);
            printf("%d %d\n", p1+1, p2-p1);
        }
    }
    return 0;
}
