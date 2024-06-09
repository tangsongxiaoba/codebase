#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

long long gcd(long long p, long long q) {
    return (q == 0) ? p : gcd(q, p%q);
}

int main() {
    int a, b, c, d, op;
    long long p, q, r;
    while(scanf("%d/%d %d/%d %d", &a, &b, &c, &d, &op) != EOF) {
        switch(op) {
            case 1:
                p = a*d + b*c;
                q = b*d;
                break;
            case 2:
                p = a*d - b*c;
                q = b*d;
                break;
            case 3:
                p = a*c;
                q = b*d;
                break;
            case 4:
                p = a*d;
                q = b*c;
                break;
            default:
                break;
        }
        if(p % q == 0) {
            printf("%lld\n", p/q);
        }
        else {
            r = gcd(p, q);
            p /= r, q /= r;
            if(q < 0) p = -p, q = -q;
            printf("%lld/%lld\n", p, q);
        }
    }
    return 0;
}
