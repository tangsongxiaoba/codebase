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
    int tot = 0, i;
    char c;
    double H = 0;
    while((c = getchar()) != EOF) {
        if(!(isdigit(c) || isalpha(c))) continue;
        cnt[(int)c] += 1;
        ++tot;
    }
    for(i = 0; i < 127; ++i) {
        if(!cnt[i]) continue;
        H += (double)cnt[i]/(double)tot * log2((double)cnt[i]/(double)tot);
    }
    printf("%.4f", 0.0-H);
    return 0;
}
