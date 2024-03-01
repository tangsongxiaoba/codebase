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

char str[1010];
int stk[1010], p;

int main() {
    int i, j, len, cnt = 0, flag = 1;
    gets(str);
    len = strlen(str);
    for(i = 0; i+3 < len; ++i) {
        if(strncmp(str+i, "0000", 4) == 0) {
            str[i+3] = 'V';
            stk[p++] = i+3;
        }
    }
    for(i = 0; i < stk[0]; ++i) {
        if(str[i] - '0' == 1) ++cnt;
    }
    if(cnt % 2 == 0) str[stk[0]-3] = 'B';
    for(i = 1; i < p; ++i) {
        cnt = 0;
        for(j = stk[i-1]+1; j < stk[i]; ++j) {
            if(str[j] - '0' == 1) ++cnt;
        }
        if(cnt % 2 == 0) str[stk[i]-3] = 'B';
    }
    for(i = 0; i < len; ++i) {
        if(str[i] == '1' || str[i] == 'B') {
            if(flag == -1) str[i] = 'A';
            else str[i] = '1';
            flag = -flag;
        }
    }
    flag = 1;
    for(i = 0; i < len; ++i) {
        if(str[i] == '1') {
            flag = 1;
        }
        else if(str[i] == 'A') {
            flag = -1;
        }
        else if(str[i] == 'V') {
            str[i] = (flag == -1 ? 'A': '1');
        }
    }
    for(i = 0; i < len; ++i) {
        if(str[i] == 'A') putchar('-'), putchar('1');
        else if(str[i] == '1') putchar('+'), putchar('1');
        else putchar(str[i]);
        putchar(' ');
    }
    return 0;
}
