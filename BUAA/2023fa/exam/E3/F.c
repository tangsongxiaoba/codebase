#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int f(int x, const int B) {
    int base, ans;
    base = 1, ans = 0;
    while(x) {
        ans += (x % 10) * base;
        base *= B;
        x /= 10;
    }
    return ans;
}

int main() {
    int a, b, c, B, m;
    long long a1, b1, c1;
    a = read(), b = read(), c = read();
    m = 1;
    for(B = a; B > 0; B /= 10) if(m < (B % 10)) m = B % 10;
    for(B = b; B > 0; B /= 10) if(m < (B % 10)) m = B % 10;
    for(B = c; B > 0; B /= 10) if(m < (B % 10)) m = B % 10;
    for(B = m+1; B <= 16; ++B) {
        a1 = f(a, B);
        b1 = f(b, B);
        c1 = f(c, B);
        if(a1*b1 == c1) break;
    }
    if(B == 17) B = 0;
    printf("%d", B);
    return 0;
}
