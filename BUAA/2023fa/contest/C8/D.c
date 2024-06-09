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

double te[110];
double av[110];

void calc(int x) {
    int i;
    double sum = 0;
    for(i = x-4; i <= x; ++i) {
        sum += te[i];
    }
    av[x] = sum/5.0;
}

int check(int x) {
    if(x < 9) return 0;
    int i;
    for(i = x-4; i <= x; ++i) {
        if(av[i] >= 10) return 0;
    }
    return 1;
}

int find(int x) {
    int i;
    for(i = x-4; i <= x; ++i) {
        if(te[i] < 10) return i;
    }
    return x;
}

int main() {
    int n;
    while(scanf("%d", &n) != EOF) {
        int i;
        for(i = 1; i <= n; ++i) av[i] = te[i] = 0;
        for(i = 1; i <= n; ++i) {
            scanf("%lf", &te[i]);
        }
        int flag = 0;
        for(i = 5; i <= n; ++i) {
            calc(i);
            if(check(i) > 0) {
                printf("Success %d\n", find(i-4));
                flag = 1;
                break;
            }
        }
        if(flag == 0) {
            puts("Failure");
        }
    }
    return 0;
}
