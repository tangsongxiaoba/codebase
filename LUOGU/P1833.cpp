//Luogu P1833 樱花
#include<cstdio>
#define N 10010
#define min(a, b) a < b ? a : b
#define max(a, b) a > b ? a : b
int n, c[N], T, t[N], p[N], f[N];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    int i, j, k, d;
    scanf("%d:%d %d:%d", &i, &j, &k, &d);
    T = (k-i)*60 +d - j;
    n = read();
    for(i = 1; i <= n; ++i) {
        t[i] = read(), c[i] = read(), p[i] = read();
        p[i] = (!p[i]) ? T / t[i] : min(p[i], T / t[i]);
        for(j = 1; j <= p[i]; j <<= 1) {
            for(k = T; k >= j * t[i]; --k)
                f[k] = max(f[k], f[k-t[i]*j] + c[i] * j);
            p[i] -= j;
        }
        if(p[i]) {
            for(k = T; k >= t[i] * p[i]; --k) 
                f[k] = max(f[k], f[k-t[i]*p[i]]+c[i]*p[i]);
        }
    }
    printf("%d", f[T]);
    return 0;
}