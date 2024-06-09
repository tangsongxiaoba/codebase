#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int sum[200010];
int delta[200010];

int main() {
    int n, m, lim, i, l, r, x, cnt;
    n = read(), m= read(), lim = read();
    cnt = 0;
    while(m--) {
        l = read(), r = read(), x = read();
        delta[l] += x;
        delta[r+1] -= x;
    }
    for(i = 1; i <= n; ++i) {
        sum[i] = delta[i] + sum[i-1];
        if(sum[i] >= lim) ++cnt;
    }
    printf("%d", cnt);
    return 0;
}
