//Luogu P1100 高低位交换
#include<cstdio>

unsigned long long x;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    x = read();
    printf("%lld", ((x & 0x0000ffff) << 16 | (x & 0xffff0000) >> 16));
    return 0;
}