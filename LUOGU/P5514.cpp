//Luogu P5514 [MtOI2019]永夜的报应
#include<cstdio>

int n, ans;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    n = read(), ans = read();
    for(register int i = 1; i < n; ++i) ans ^= read();
    printf("%d", ans);
    return 0;
}