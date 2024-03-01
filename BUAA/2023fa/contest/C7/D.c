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
    while(scanf("%s", s) != EOF) {
        int i, len = strlen(s);
        for(i = 0; i < len; ++i) {
            s[i] = tolower(s[i]);
        }
        char* p = strstr(s, "kiss");
        if(p == NULL) {
            printf("0 -1\n");
        }
        else {
            int cnt = 1;
            char *p2;
            while(1) {
                p2 = strstr(p+1, "kiss");
                if(p2 == NULL) break;
                p = p2;
                ++cnt;
            }
            printf("%d %lld\n", cnt, p-s);
        }
    }
    return 0;
}
