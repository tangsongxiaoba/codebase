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
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}

const char C[] = "VIOLET";

LL mat[1010][1010], ans;
int cnt[6];

LL check(int i, int j, char C) {
    LL res = 0;
    switch(C) {
        case 'V':
            res = mat[i][j]+mat[i][j+2]+mat[i+1][j]+mat[i+1][j+2]+mat[i+2][j+1];
            break;
        case 'I':
            res = mat[i][j+1]+mat[i+1][j+1]+mat[i+2][j+1];
            break;
        case 'O':
            res = mat[i][j]+mat[i][j+1]+mat[i][j+2]+mat[i+1][j]+mat[i+1][j+2]+mat[i+2][j]+mat[i+2][j+1]+mat[i+2][j+2];
            break;
        case 'L':
            res = mat[i][j]+mat[i+1][j]+mat[i+2][j]+mat[i+2][j+1]+mat[i+2][j+2];
            break;
        case 'E':
            res = mat[i][j]+mat[i][j+1]+mat[i][j+2]+mat[i+1][j]+mat[i+1][j+2]+mat[i+2][j]+mat[i+2][j+1]+mat[i+2][j+2]+mat[i+1][j+1];
            break;
        case 'T':
            res = mat[i][j+1]+mat[i+1][j+1]+mat[i+2][j+1]+mat[i][j]+mat[i][j+2];
            break;
        default:
            break;
    }
    return res;
}

int main() {
    int m = read(), n = read(), i, j, k;
    for(i = 1; i <= m; ++i) {
        for(j = 1; j <= n; ++j) {
            mat[i][j] = read();
        }
    }
    for(i = 1; i + 2 <= m; ++i) {
        for(j = 1; j + 2 <= n; ++j) {
            for(k = 0; k < 6; ++k) {
                LL t = check(i, j, C[k]);
                if(ans < t) {
                    memset(cnt, 0, sizeof(cnt));
                    ans = t;
                    cnt[k] = 1;
                } else if(ans == t) cnt[k] = 1;
            }
        }
    }
    printf("%lld\n", ans);
    for(k = 0; k < 6; ++k) {
        if(cnt[k]) putchar(C[k]);
    }
    return 0;
}
