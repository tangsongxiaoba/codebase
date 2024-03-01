#include<stdio.h>
#include<math.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

struct p{
    long long x, y;
}a[53];

long long gcd(long long a, long long b) {
    return b == 0 ? a : gcd(b, a%b);
}

long long area(long long x1, long long y1, long long x2, long long y2) {
    return x1*y2-x2*y1;
}

int main() {
    int n, i;
    long long b, s, ans;
    n = read();
    b = s = 0;
    for(i = 1; i <= n; ++i) {
        a[i].x = read(), a[i].y = read();
    }
    a[n+1] = a[1];
    for(i = 1; i <= n; ++i) {
        if(a[i+1].x == a[i].x) b += abs(a[i+1].y-a[i].y);
        else b += gcd(abs(a[i+1].x-a[i].x), abs(a[i+1].y-a[i].y));
        s += area(a[i+1].x, a[i+1].y, a[i].x, a[i].y);
    }
    ans = (s-b+2LL)>>1;
    printf("%lld", ans);
    return 0;
}
