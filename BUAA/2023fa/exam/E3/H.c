#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int a[500010], sum[500010], q[500010];

double k(const int i, const int j) {
    return 1.0*(sum[j] - sum[i])/(j - i);
}

int main() {
    int n, m, i, j, h, t;
    double M;
    n = read(), m = read();
    h = 0, t = 1;
    M = 0;
    for(i = 1; i <= n; ++i) {
        a[i] = read();
        sum[i] = sum[i-1] + a[i];
    }
    for(i = m; i <= n; ++i) {
        while(h+1 < t && (k(q[h], i) < k(q[h+1], i) || i-q[h]+1 > t)) ++h;
        if(M < k(q[h], i)) M = k(q[h], i);
        j = i - m + 1;
        while(h+1 < t && k(q[t-1], j) < k(q[t-2], q[t-1])) --t;
        q[t++] = j;
    }
    printf("%d", (int)(M+0.5));
    return 0;
}
