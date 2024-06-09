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
    return f?-x:x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

char s[1010];

int main() {
    char c;
    gets(s);
    while((c = getchar()) != EOF) {
        if(c < 32 || c > 126) continue;
        char* p1 = strchr(s, c);
        char* p2 = strrchr(s, c);
        if(p1 == NULL) {
            puts("-1");
        }
        else if(p1 == p2) {
            printf("%lld\n", p1-s);
        }
        else {
            printf("%lld\n", p2-p1);
        }
    }
    return 0;
}
