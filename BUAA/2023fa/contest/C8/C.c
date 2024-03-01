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

char s1[100], s2[100];

int main() {
    int a = read(), b = read(), c = read(), d = read();
    printf("%lld\n%lld\n", 1LL*a+b, 1LL*c+d);
    sprintf(s1, "%lld", 1LL*a+b);
    sprintf(s2, "%lld", 1LL*c+d);
    if(strcmp(s1, s2) < 0) puts("a+b<c+d");
    else if(strcmp(s1, s2) > 0) puts("a+b>c+d");
    else puts("a+b=c+d");
    return 0;
}
