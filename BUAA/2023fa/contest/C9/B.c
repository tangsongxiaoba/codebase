#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define UL unsigned long long
#define UU unsigned int
#define SWAP(a, b) (((a) ^ (b)) && ((b) ^= (a) ^= (b), (a) ^= (b)))

#define IO_TYPE int
IO_TYPE read() {
    register IO_TYPE x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= (c == '-'), c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}
void write(IO_TYPE x) {
    static short sta[23];
    short top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}
#undef IO_TYPE

int p[15][15];

long long qpow(long long a, unsigned long long b) {
    long long ans = 1;
    while(b) {
        if(b & 1)
            ans = (ans * a);
        b >>= 1;
        a = a * a;
    }
    return ans;
}

int main() {
    int i, j, m = 10, n = 10;
    p[0][0] = 1;
    for(i = 0; i <= m ; i++) {
        for(j = 0; j <= n; j++) {
            if(i == 0 && j == 0) continue;
            else if(i == 0) p[i][j] = p[i][j - 1];
            else if(j == 0) p[i][j] = p[i - 1][j];
            else p[i][j] = p[i - 1][j] + p[i][j - 1];
        }
    }
    int a = read(), b = read(), nn = read(), k = read();
    long long ans = p[k][nn-k];
    ans *= qpow(a, nn-k);
    ans *= qpow(b, k);
    printf("%lld", ans);
    return 0;
}
