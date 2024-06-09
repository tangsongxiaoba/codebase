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

char s[2010], s1[1010], s2[1010];
void op() {
    int i, len = strlen(s);
    for(i = len; i-len < len; ++i) {
        s[i] = s[2*len-i-1];
    }
    len *= 2;
    int p1 = 0, p2 = 0;
    for(i = 0; i < len; ++i) {
        if(i % 2 == 0) s2[p2++] = s[i];
        else s1[p1++] = s[i];
    }
    memset(s, 0, sizeof(s));
    if(strcmp(s1, s2) < 0) {
        strcpy(s, s1);
    }
    else strcpy(s, s2);
}

int main() {
    gets(s);
    int n = read();
    while(n) {
        op();
        n--;
    }
    printf("%s", s);
    return 0;
}
