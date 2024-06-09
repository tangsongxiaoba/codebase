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

int main() {
    char s[100];
    char s1[100];
    gets(s);
    gets(s1);
    int len = strlen(s), len1 = strlen(s1), flag = 0, m = 0, n = 0;
    int i = 1;
    if(s[1] == '-') flag = true, ++i;
    while(isdigit(s[i])) {
        n = n * 10 + s[i] - '0';
        ++i;
    }
    ++i;
    while(isdigit(s[i])) {
        m = m * 10 + s[i] - '0';
        ++i;
    }
    if(flag == false) {
        for(i = 0; i < n && i < len1; ++i) {
            putchar(s1[i]);
        }
        if(m - i > 0) {
            for(int j = m-i; j > 0; --j) putchar('#');
        }
    }
    else {
        int l = n > len1 ? len1 : n;
        if(m - l > 0) {
            for(int j = m-l; j > 0; --j) putchar('#');
        }
        for(i = 0; i < l; ++i) {
            putchar(s1[i]);
        }
    }
    return 0;
}
