#include<stdio.h>
#include<string.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int x[97];

int main() {
    int t;
    int m, n, len, i, a, p, base;
    t = read();
    while(t--) {
        a = 0;
        p = 0;
        m = read(), n = read();
        base = 1;
        char s[11];
        scanf("%s", s);
        len = strlen(s);
        if(s[0] == '0') {
            puts("0");
            continue;
        }
        for(i = len-1; i >= 0; --i) {
            a += (s[i]-'0') * base;
            base *= m;
        }
        while(a > 0) {
            x[++p] = a % n;
            a /= n;
        }
        for(i = p; i > 0; --i) {
            printf("%c", x[i]+'0');
        }
        puts("");
    }
    return 0;
}
