#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

int an[1000010];

int cmp(const void *p, const void *q) {
    int *a = (int *)p;
    int *b = (int *)q;
    return (*a) - (*b);
}

int main(void) {
    int t = read();
    while(t--) {
        int n = read();
        long long sum = 0, x = 0;
        for(int i = 0; i < n; ++i) {
            an[i] = read();
            sum += 1LL * an[i];
        }
        if(n == 1 || n == 2) {
            puts("-1");
            continue;
        }
        qsort(an, n, sizeof(an[0]), cmp);
        int target = an[(n + (n % 2 == 0)) / 2];
        x = 2LL * n * target - sum + 1LL;
        printf("%lld\n", x < 0 ? 0 : x);
    }
    return 0;
}
