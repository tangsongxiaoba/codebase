#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int main() {
    char pre = '\0', now = '\0', nxt = '\0';
    while((nxt = getchar()) != '\n') {
        if(now == pre + 1 && nxt == now + 1) {
            while(nxt == now + 1) {
                now = nxt;
                nxt = getchar();
            }
            putchar('-');
        }
        if(isprint(now)) putchar(now);
        pre = now;
        now = nxt;
    }
    if(isprint(now)) putchar(now);
    return 0;
}
