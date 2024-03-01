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

char s[1010], str[1010], s0[1010], s1[1010];

int main() {
    gets(s);
    int len = strlen(s), i;
    for(i = 0; i < len; ++i) {
        if(s[i] == '0') s[i] = 'o';
    }
    if(len % 2 == 0) {
        i = len >> 1;
        for(; i < len; ++i) {
            s[i] = 'a' + 'z' - s[i];
        }
        int h = 0;
        for(i = 0; i < len; ++i) {
            s0[i] = s[h];
            if(h < (len >> 1)) h = len - 1 - h;
            else h = len - h;
        }
        h = len - 1;
        for(i = 0; i < len; ++i) {
            s1[i] = s[h];
            if(h < (len >> 1)) h = len - 2 - h;
            else h = len - 1 - h;
        }
        if(strcmp(s0, s1) > 0) strcpy(str, s1);
        else strcpy(str, s0);
    }
    else {
        i = (len >> 1) + 1;
        for(; i < len; ++i) {
            s[i] = 'a' + 'z' - s[i];
        }
        int h = 0;
        for(i = 0; i < len; ++i) {
            s0[i] = s[h];
            if(h < (len >> 1)) h = len - 1 - h;
            else h = len - h;
        }
        h = len - 1;
        for(i = 0; i < len-1; ++i) {
            s1[i] = s[h];
            if(h < (len >> 1)) h = len - h - 2;
            else h = len - 1 - h;
        }
        s1[len-1] = 'a' + 'z' - s[len >> 1];
        if(strcmp(s0, s1) > 0) strcpy(str, s1);
        else strcpy(str, s0);
    }
    for(i = 0; i < len; ++i) {
        printf("%c", str[i]);
    }
    return 0;
}
