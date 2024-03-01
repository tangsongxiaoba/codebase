#include<stdio.h>

unsigned int read() {
    register unsigned int x = 0;
    register char c = getchar();
    while(c < '0' || c > '9') c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x;
}

void print(const unsigned int x) {
    int i;
    for(i = 31; i >= 0; --i) {
        putchar(((x >> i) & 1) + '0');
    }
    putchar('\n');
    return;
}

int main() {
    unsigned int a, b, c, d, e;
    a = read(), b = read();
    c = a & b;
    d = a ^ b;
    e = (c << 1) + d;
    print(a), print(b), print(c), print(d), print(e);
    printf("%u", e);
    
    return 0;
}
