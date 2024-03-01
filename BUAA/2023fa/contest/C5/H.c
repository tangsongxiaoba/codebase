#include <stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

void f(int l, int r, int c) {
    if(l == 1) {
        if(c == 0) printf("1");
    } else if(l == 2) {
        if(c == 0) printf("10");
        else printf("0");
    } else if(l == 3) {
        if(c == 0) printf("101");
        else printf("01");
    } else {
        if(l % 2) {
            f(l / 2 + 1, l / 2 + 1, c);
        } else {
            f(l / 2, l / 2 + 1, c);
        }
    }
    if(r == 1) {
        return;
    } else if(r == 2) {
        printf("0");
    } else if(r == 3) {
        printf("01");
    } else {
        if(r % 2) {
            f(r / 2 + 1, r / 2 + 1, 1);
        } else {
            f(r / 2, r / 2 + 1, 1);
        }
    }
}

int main() {
    int n;
    n = read();
    if(n == 3) return printf("101"), 0;
    if(n % 2) {
        f(n / 2 + 1, n / 2 + 1, 0);
    } else {
        f(n / 2, n / 2 + 1, 0);
    }
    return 0;
}
