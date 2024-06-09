#include<stdio.h>

unsigned int read() {
    register unsigned int x = 0;
    register char c = getchar();
    while(c < '0' || c > '9') c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x;
}

int main() {
    int i;
    unsigned int T, n, ans;
    T = read();
    while(T--) {
        n = read();
        ans = 0;
        for(i = 0; i < 32; ++i) {
            if((n >> i) & 1) break;
        }
        ans |= (1 << i);
        if(!(ans ^ n)) {
            i = 0;
            while((n >> i) & 1) ++i;
            ans |= (1 << i);
        }
        printf("%u\n", ans);
    }
    return 0;
}
