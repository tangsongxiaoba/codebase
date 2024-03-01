#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    int n;
    unsigned int u;
    n = read();
    while(n--) {
        scanf("%u", &u);
        u = ((u & 0xffff0000) >> 16 | ((u & 0xffff) << 16));
        printf("%u\n", u);
    }
    return 0;
}
