#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

char qu[1000];

int main() {
    char ch;
    int hu = 0, tu = 0, f = -1, i;
    while((ch = getchar()) != EOF) {
        if(isdigit(ch)) qu[tu++] = ch;
        else if(ch == '.') f = tu - 1;
    }
    while(qu[tu - 1] == '0') --tu;
    while(qu[hu] == '0') ++hu;
    if(hu > tu) putchar('0');
    else {
        putchar(qu[hu]);
        if(tu > hu + 1) {
            putchar('.');
            for(i = hu + 1; i < tu; ++i) putchar(qu[i]);
        }
    }
    putchar('e');
    if (f == -1) putchar('0');
    else printf("%d", f - hu);
    return 0;
}
