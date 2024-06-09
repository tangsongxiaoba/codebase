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

char s[1010];

int main() {
    while(scanf("%s", s) != EOF) {
        int len = strlen(s);
        int i = (len >> 1) - 1, cnt = 0;
        while(i >= 0) {
            if(s[i] != s[len - 1 - i]) ++cnt;
            --i;
        }
        if(cnt == 0) puts("yes");
        else printf("no %d\n", cnt);
    }
    return 0;
}
