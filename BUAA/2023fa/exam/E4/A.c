#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    char c;
    int n, i, j;
    c = getchar();
    n = read();
    for(i = 0; i <= n; ++i) {
        for(j = 1; j <= i; ++j) {
            putchar(' ');
        }
        for(j = 1; j <= n-i; ++j) {
            putchar(c);
        }
        puts("");
    }
    return 0;
}
