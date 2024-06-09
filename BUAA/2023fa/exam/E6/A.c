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
    int n = read(), sum = 0;
    char c = 0;
    sum += n;
    while(1) {
        c = getchar();
        if(c == '=') break;
        n = read();
        if(c == '+') {
            sum += n;
        }
        else if(c == '-') {
            sum -= n;
        }
        else {
            puts("PANIC!!!");
        }
    }
    write(sum);
    return 0;
}
