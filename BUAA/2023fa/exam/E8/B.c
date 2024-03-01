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
    puts("");
}

int main() {
    int T = read();
    while(T--) {
        int x1 = read(), y1 = read(), x2 = read(), y2 = read();
        int dx = x2-x1, dy = y2-y1, cnt = 0, flag = 0;
        char c;
        while((c = getchar()) != '\n') {
            if(!isalpha(c) && !flag) continue;
            if(c == 'N') {
                if(dy > 0) ++cnt, --dy;
            }
            else if(c == 'S') {
                if(dy < 0) ++cnt, ++dy;
            }
            else if(c == 'E') {
                if(dx > 0) ++cnt, --dx;
            }
            else if(c == 'W') {
                if(dx < 0) ++cnt, ++dx;
            }
            if(dx == dy && dx == 0) flag = 1;
        }
        if(flag == 1) write(cnt);
        else puts("We want to live in Gensokyo forever...");
    }
    return 0;
}
