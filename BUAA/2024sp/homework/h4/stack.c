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
    putchar(' ');
}

int s[110], p;

int main() {
    int t;
    while((t = read()) != -1) {
        switch(t) {
            case 1:
                if(p == 101) printf("error ");
                else s[p++] = read();
                break;
            case 0:
                if(p == 0) printf("error ");
                else write(s[--p]);
                break;
            default:
                break;
        }
    }
    return 0;
}
