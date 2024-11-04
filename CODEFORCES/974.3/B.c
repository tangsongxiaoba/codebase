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
        if(k % 2 == 1) {
            if(n % 2 == 1) {
                if(k % 4 == 1) {
                    puts("NO");
                } else
                    puts("YES");
            } else {
                if(k % 4 == 1) {
                    puts("YES");
                } else
                    puts("NO");
            }
        } else {
            if(k % 4 == 0) {
                puts("YES");
            } else
                puts("NO");
        }
    }
    return 0;
}
