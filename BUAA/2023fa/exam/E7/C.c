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

char ma[110][510];
int p, i;

char s[10][50] = {"#include<stdio.h>", "int main()", "{", "    puts(\"", "\");", "    return 0;", "}"};

int main() {
    while(gets(ma[p]) != NULL) {
        ++p;
    }
    printf("%s\n%s\n%s\n", s[0], s[1], s[2]);
    for(i = 0; i < p; ++i) {
        printf("%s", s[3]);
        int len = strlen(ma[i]), j;
        for(j = 0; j < len; ++j) {
            if(ma[i][j] == '\\' || ma[i][j] == '\'' || ma[i][j] == '\"' || ma[i][j] == '\?')
                putchar('\\');
            putchar(ma[i][j]);
        }
        printf("%s\n", s[4]);
    }
    printf("%s\n%s", s[5], s[6]);
    return 0;
}
