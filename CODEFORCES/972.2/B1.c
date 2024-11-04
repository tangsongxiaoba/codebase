#include <stdio.h>

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

int main(void) {
    int t = read();

    while(t--) {
        int n = read(), m = read(), q = read();
        int m1 = read(), m2 = read();
        q = read();
        int x = m1 > m2 ? m2 : m1;
        int y = m1 > m2 ? m1 : m2;
        if(q == x || q == y) {
            printf("0\n");
        } else if(q < x) {
            printf("%d\n", x-1);
        } else if(q > y) {
            printf("%d\n", n-y);
        } else {
            printf("%d\n", (y-x)/2);
        }
    }
    return 0;
}
