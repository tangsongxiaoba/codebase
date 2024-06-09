//Luogu P2398 GCD SUM
#include<cstdio>

long long n;
long long ans, f[100010];

inline long long read() {
    register long long x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    n = read();
    for(register int i = n; i; --i) {
        f[i] = n / i * (n / i);
        for(register int j = (i << 1); j <= n; j += i) f[i] -= f[j];
        ans += f[i] * i;
    }
    printf("%lld", ans);
    return 0;
}