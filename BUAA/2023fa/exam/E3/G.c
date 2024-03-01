#include<stdio.h>

unsigned int read() {
    register unsigned int x = 0;
    register char c = getchar();
    while(c < '0' || c > '9') c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x;
}

int main() {
    int n, m, o;
    unsigned int t, x;
    n = read();
    while(n--) {
        m = read();
        o = m;
        t = read();
        --m;
        while(m--) {
            x = read();
            t ^= x;
        }
        if(o % 2 == 0) puts("Congratulations!");
        else printf("Single Dog! %u\n", t);
    }
    return 0;
}
