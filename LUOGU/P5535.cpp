//Luogu P5535 【XR-3】小道消息
#include<cstdio>

long long n, k;

inline long long read() {
    register long long x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

inline bool isprime(const long long& x) {
    if(x == 1) return 0;
    if(x == 2) return 1;
    for(register long long i = 2; i * i <= x; ++i)
        if(!(x % i)) return 0;
    return 1;
}

int main() {
    n = read(), k = read();
    if(isprime(k+1) && (k << 1) >= n) puts("1");
    else puts("2");
    return 0;
}