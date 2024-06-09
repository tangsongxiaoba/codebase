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
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int cnt[127];

int main() {
    int n = read(), i, m = 0, mx = 0;
    char c;
    while(n > 0) {
        c = getchar();
        if(!isalpha(c)) putchar(c);
        else {
            if(isupper(c)) putchar(c-'A'+'a');
            else putchar(c-'a'+'A');
        }
        ++cnt[(int)c];
        --n;
    }
    puts("");
    for(i = 0; i < 127; ++i) {
        if(m < cnt[i]) m = cnt[i], mx = i;
    }
    putchar(mx);
    puts("");
    write(m);
    return 0;
}
