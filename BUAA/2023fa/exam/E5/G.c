#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int a[12], n;

void f(int x) {
    int p, i;
    for(i = 0; i <= 11; ++i) a[i] = 0;
    p = 0;
    while(x) {
        a[++p] = x % 2;
        x >>= 1;
    }
    for(i = n; i >= 1; --i) {
        putchar(a[i]+'0');
    }
    puts("");
}

int main() {
    int i;
    n = read();
    for(i = 0; i <= (1 << n)-1; ++i) {
        f(i ^ (i >> 1));
    }
    return 0;
}
