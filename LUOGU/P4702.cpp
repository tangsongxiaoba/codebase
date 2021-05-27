//Luogu P4702 取石子
#include<cstdio>

int n, a, ans;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    n = read();
    while(n--) ans += read();
    if(!(ans & 1)) puts("Bob");
    else puts("Alice");
    return 0;
}