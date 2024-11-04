#include <stdio.h>

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}


int main(void) {
    int t = read();
    while(t--) {
        int n = read(), k = read();
        int m = 0, cnt = 0;
        for(int i = 0; i < n; ++i) {
            int a = read();
            if(a >= k) m += a;
            else if(a == 0 && m != 0) ++cnt, --m;
        }
        printf("%d\n", cnt);
    }
    return 0;
}
