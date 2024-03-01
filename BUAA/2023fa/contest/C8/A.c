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
    puts(" _   _      _ _         _    _            _     _\n| | | |    | | |       | |  | |          | |   | |  %\n| |_| | ___| | | ___   | |  | | ___  _ __| | __| |  %\n|  _  |/ _ \\ | |/ _ \\  | |/\\| |/ _ \\| \"__| |/ _\' |  %\n| | | |  __/ | | (_) | \\  /\\  / (_) | |  | | (_| |  %\n\\_| |_/\\___|_|_|\\___/   \\/  \\/ \\___/|_|  |_|\\__,_|  .");
    return 0;
}
