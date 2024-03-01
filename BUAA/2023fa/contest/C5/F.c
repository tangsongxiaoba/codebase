#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int prime[2010];

int check(int i) {
    if(i < 2) return 0;
    int a;
    for(a = 2; a * a <= i; ++a) {
        if(i % a == 0) return 0;
    }
    return 1;
}

int main() {
    int i, l, r, p, cnt;
    l = read(), r = read();
    p = cnt = 0;
    for(i = l; i <= r; ++i) {
        if(check(i)) prime[++p] = i;
    }
    for(i = 2; i <= p; ++i) {
        if(prime[i] - prime[i-1] == 2) {
            printf("%d %d\n", prime[i-1], prime[i]);
            ++cnt;
        }
    }
    printf("%d", cnt);
    return 0;
}
