//Luogu P5657 [CSP-S2019] 格雷码
#include<cstdio>

int n;
unsigned long long k;

inline long long read() {
    register long long x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    n = read(), k = read();
    k ^= k >> 1;
    while(~--n) printf("%lld", k >> n & 1);
    return 0;
}