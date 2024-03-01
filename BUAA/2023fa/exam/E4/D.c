#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int q[1010];

int main() {
    int n, k, i, cnt, j;
    n = read(), k = read();
    cnt = 0; i = 0;
    while(cnt < n-1) {
        for(j = 1; j <= k; ++j) {
            ++i, i %= n;
            while(q[i]) ++i, i %= n;
        }
        q[i] = 1;
        ++cnt;
    }
    for(i = 0; i < n; ++i) {
        if(!q[i]) break;
    }
    printf("%d", i == 0 ? n : i);
    return 0;
}
