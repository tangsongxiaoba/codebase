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

char* otter[10001];
char s[1001];

int main() {
    int n = read(), m = read(), i;
    /*getchar(); getchar();*/
    for(i = 1; i <= n; ++i) {
        gets(s);
        otter[i] = (char*)malloc((int)strlen(s)*sizeof(char) + 1);
        strcpy(otter[i], s);
    }
    for(i = 1; i <= m; ++i) {
        int a = read(), b = read();
        char* t = otter[a];
        otter[a] = otter[b];
        otter[b] = t;
    }
    for(i = 1; i <= n; ++i) {
        puts(otter[i]);
        free(otter[i]);
    }
    return 0;
}
