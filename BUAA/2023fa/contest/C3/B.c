#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    unsigned int n;
    int t, k, op;
    scanf("%u", &n);
    t = read();
    while(t--) {
        k = read(), op = read();
        if(op) {
            n = n | (1 << k);
        }
        else {
            n = n & ~(1 << k);
        }
        printf("%u\n", n);
    }
    printf("%u", n);
    return 0;
}
