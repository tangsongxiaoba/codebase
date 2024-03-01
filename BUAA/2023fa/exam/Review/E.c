#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}

long long qpow(long long a, unsigned long long b) {
    long long ans = 1;
    a = a;
    while (b) {
        if (b & 1)
            ans = (ans * a);
        b >>= 1;
        a = a * a;
    }
    return ans;
}

int main() {
    char c;
    int cnt = 1, num = getchar() - '0';
    while((c = getchar()) != '\n' && c != '\r' && c != ' ') ++cnt;
    int m = read();
    LL ans = num;
    while(cnt-- > 1) {
        ans = (ans * 10 + num) % m;
    }
    printf("%lld", ans);
    return 0;
}
