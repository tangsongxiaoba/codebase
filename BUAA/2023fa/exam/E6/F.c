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

int len, k;
char s[110];

int less(int x) {
    int i;
    for(i = 0; i < len; ++i) {
        if(s[(k+i)%len] > s[(x+i)%len]) return 1;
        else if(s[(k+i)%len] < s[(x+i)%len]) return 0;
    }
    return 2;
}

int main() {
    int i;
    gets(s);
    len = strlen(s);
    for(i = 1; i < len; ++i) {
        if(less(i) == 1) {
            k = i;
        }
        else if(less(i) == 2) {
            break;
        }
    }
    for(i = 0; i < len; ++i) {
        putchar(s[(k+i)%len]);
    }
    return 0;
}
