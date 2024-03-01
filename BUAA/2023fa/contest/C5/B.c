#include<stdio.h>

long long read() {
    register long long x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3ll) + (x << 1ll) + (c ^ 48ll), c = getchar();
    return f?-x:x;
}

long long qpow(long long a, unsigned long long b, long long p)
{
    long long ans = 1;
    a = a % p;
    while (b)
    {
        if (b & 1)
            ans = (ans * a) % p;
        b >>= 1;
        a = a * a % p;
    }
    return ans;
}

int main() {
    long long a, b, p;
    a = read(), b = read(), p = read();
    printf("%lld", qpow(a, b, p));
    return 0;
}
