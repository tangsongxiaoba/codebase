#include <stdio.h>

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

char c[] = "aeiou";

int main(void) {
    int t = read();
    while(t--) {
        int n = read();
        for(int i = 0; i < 5; ++i) {
            for(int j = 0; j < n / 5; ++j) {
                putchar(c[i]);
            }
            if(i < n % 5) putchar(c[i]);
        }
        putchar('\n');
    }
    return 0;
}
