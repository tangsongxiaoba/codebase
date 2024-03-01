#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    int n, m, opt, i, cnt;
    unsigned long long x;
    n = read(), m = read();
    cnt = 0;
    x = 0;
    while(m--) {
        opt = read();
        if(opt == 1) {
            x = ~x;
        }
        else {
            for(i = 0; i < n; ++i) {
                if((x >> i) & 1) continue;
                x = x | (1ull << i);
                break;
            }
        }
    }
    if(x == 0) return puts("0"), 0;
    for(i = 0; i < n; ++i) {
        if((x>>i)&1) printf("%d ", i+1), ++cnt;
    }
    puts("");
    printf("%d", cnt);
    return 0;
}
