#include <stdio.h>
#include <string.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

int q[3000010], a[3000010];
long long sum[3000010];

int main() {
    long long i, ans, head, tail, n, m;
    n = read();
    m = read();
    if(m > n) m = n;
    head = 1, tail = 1;
    ans = -1e13 - 10;
    for(i = 1; i <= n; ++i) {
        a[i] = read();
        a[n + i] = a[i];
    }
    for(i = 1; i <= 2*n; ++i) {
        sum[i] = sum[i - 1] + a[i];
    }
    for(i = 1; i <= 2*n; ++i) {
        while(head <= tail && q[head] < i - m) ++head;
        if(ans < sum[i] - sum[q[head]]) ans = sum[i] - sum[q[head]];
        while(head <= tail && sum[q[tail]] >= sum[i]) --tail;
        q[++tail] = i;
    }
    printf("%lld", ans);
    return 0;
}
