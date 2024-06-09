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
    int t = read();
    while(t--) {
        int S[20][20], T[20][20], i, j, flag = 0;
        for(i = 1; i <= 9; ++i) {
            for(j = 1; j <= 9; ++j) {
                S[i][j] = read();
            }
        }
        for(i = 1; i <= 9; ++i) {
            for(j = 1; j <= 9; ++j) {
                T[i][j] = read();
            }
        }
        for(i = 1; i <= 9; ++i) {
            int check[10] = {0};
            for(j = 1; j <= 9; ++j) {
                if((check[T[i][j]] != 0) || (S[i][j] != 0 && S[i][j] != T[i][j])) {
                    flag = 1;
                    break;
                }
                ++check[T[i][j]];
            }
            if(flag == 1) break;
        }
        for(j = 1; j <= 9; ++j) {
            int check[10] = {0};
            for(i = 1; i <= 9; ++i) {
                if(check[T[i][j]] != 0) {
                    flag = 1;
                    break;
                }
                ++check[T[i][j]];
            }
            if(flag == 1) break;
        }
        for(i = 1; i <= 9; ++i) {
            int check[10] = {0}, k;
            for(j = 1; j <= 3; ++j) {
                for(k = 1; k <= 3; ++k) {
                    int x = ((i-1)/3)*3+1+(j-1), y = ((i-1)/3)*3+1+(k-1);
                    if(check[T[x][y]] != 0) {
                        flag = 1;
                        break;
                    }
                    ++check[T[x][y]];
                }
                if(flag == 1) break;
            }
            if(flag == 1) break;
        }
        if(flag == 0) puts("Moca finish this sudoku perfectly!");
        else puts("Moca is so careless!");
    }
    return 0;
}
