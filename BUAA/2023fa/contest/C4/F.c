#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int x[1000010];

int main() {
    int p, q, r, s, i;
    p = read(), q = read();
    s = 0;
    while(1) {
        x[++s] = p/q;
        if((r = p%q) == 0) break;
        p = q;
        q = r;
    }
    for(i = 1; i <= s; ++i) {
        printf("%d ", x[i]);
    }
    return 0;
}
