//Luogu P1757 通天之分组背包
#include<cstdio>
#define N 1010
#define max(a, b) a > b ? a : b

int n, m, a, b, c1, c2, f[N];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    m = read(); n = read();
    for(register int i = 1; i <= n; ++i) {
        a = read(), b = read(), c2 = read();
        for(register int j = m; j >= a; --j)
            f[j] = (c2 != c1) ? max(f[j], f[j-a] + b) : max(f[j], f[j-1]);
        c1 = c2;
    }
    printf("%d", f[m]);
    return 0;
}