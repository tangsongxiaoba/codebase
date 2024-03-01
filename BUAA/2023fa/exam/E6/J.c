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
    if(x < 0) {
        putchar('-');
        x = -x;
    }
    static int sta[35];
    int top = 0;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int num[100010];
long long ans;
int L[50010], R[50010]; 

void Merge(int l, int mid, int r) {
    int  n1 = mid - l + 1, n2 = r - mid;
    for(int i = 0; i < n1; ++i) L[i] = num[l + i];
    for(int i = 0; i < n2; ++i) R[i] = num[mid + i + 1];
    int m = 0;
    for(int i = 0; i < n2; ++i) {
        for(; m < n1 && L[m] <= R[i]; ++m);
        ans += n1 - m;
    }
    int i = 0, j = 0, k = l;
    while(i < n1 && j < n2)
        if( L[i] < R[j] ) num[k++] = L[i++];
    else num[k++] = R[j++];
    while(i < n1) num[k++] = L[i++];
    while(j < n2) num[k++] = R[j++];
}

void Merge_Sort(int l, int r) {
    if(l < r) {
        int mid = (l + r) >> 1;
        Merge_Sort(l, mid);
        Merge_Sort(mid+1, r);
        Merge(l, mid, r);
    }
}

int main() {
    int n;
    scanf("%d", &n);
    for(int i=0; i<n; ++i) scanf("%d", &num[i]);
    Merge_Sort(0, n-1);
    printf("%lld", ans);
    return 0;
}

