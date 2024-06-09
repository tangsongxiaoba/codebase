//Luogu P1348 Couple number
#include<cstdio>

int l, r, ans;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    l = read(), r = read();
    for(register int i = l; i <= r; ++i) if(!(i % 4) || i % 2) ++ans;
    printf("%d", ans);
    return 0;
}