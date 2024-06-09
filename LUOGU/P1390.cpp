//Luogu P1390 公约数的和
#include<cstdio>

long long n;
long long ans, f[2000010];

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
    printf("%lld", ((ans - (n * (n+1) >> 1)) >> 1));
    return 0;
}