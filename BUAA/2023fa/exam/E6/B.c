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
    if(x < 0) {
        putchar('-');
        x = -x;
    }
    static int sta[35];
    int top = 0;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int main() {
    char s[32];
    int n;
    while(gets(s) != NULL) {
        n = read();
        if(!strcmp(s, "char")) {
            printf("%d\n", n*(int)sizeof(char));
        }
        else if(!strcmp(s, "short")) {
            printf("%d\n", n*(int)sizeof(short));
        }
        else if(!strcmp(s, "int")) {
            printf("%d\n", n*(int)sizeof(int));
        }
        else if(!strcmp(s, "long")) {
            printf("%d\n", n*(int)sizeof(long));
        }
        else if(!strcmp(s, "long long")) {
            printf("%d\n", n*(int)sizeof(long long));
        }
        else {
            puts("Err0r!");
        }
    }
    return 0;
}
