#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

long long qp(long long a, unsigned long long b)
{
    long long ans = 1;
    while (b)
    {
        if (b & 1)
            ans = (ans * a);
        b >>= 1;
        a = a * a;
    }
    return ans;
}

int main() {
    int a, b, x1, x2;
    while(scanf("%d%d", &a, &b) != EOF) {
        if(a == b) puts("0");
        else {
            x1 = qp(a, b);
            x2 = qp(b, a);
            if(x1 > x2) printf("%d\n", x1 - x2);
            else printf("%d\n", x2 - x1);
        }
    }
    return 0;
}
