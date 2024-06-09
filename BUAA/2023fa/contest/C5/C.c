#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int a, b, i;
long long x;

long long f(long long x) {
    return ((1LL*a*x*x+x) % b + b) % b;
}

int main() {
    a = read(), b = read();
    while(scanf("%lld", &x) != EOF) {
        for(i=1;i<=3;i++) {
            x = f(x);
        }
        printf("%lld\n", x);
    }
    return 0;
}
