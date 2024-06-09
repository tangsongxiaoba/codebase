//Luogu P5436 【XR-2】缘分
#include<cstdio>

int T, n;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    T = read();
    while(T--) {
        n = read();
        if(n == 1) {
            puts("1");
            continue;
        }
        printf("%lld\n", 1LL * n * (n-1));
    }
    return 0;
}