#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

long long f(int x) {
    if(x == 1 || x == 2) return 1;
    else if(x == 3) return 2;
    else if(x % 2) return 2LL*f((x+1)/2)-1LL;
    else return f(x/2) + f(x/2+1) - 1LL;
}

int main() {
    int m, n;
    long long a, b, c;
    m = read(), n = read();
    a = f(m)*f(n);
    b = 1LL*m*f(n)+1LL*n*f(m)-a;
    c = 1LL*m*n-b;
    printf("%lld\n%lld\n%lld", a, b, c);
    return 0;
}
