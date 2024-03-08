#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int ansX, ansY;
int ma[30][30];

int check(int op, int x, int y) {
    int i, j = y, cnt = 0;
    //h
    while(ma[x][j] == op && j >= 1) --j, ++cnt;
    for(i = y+1; ma[x][i] == op && i <= 19; ++i) ++cnt;
    if(cnt == 4 && (ma[x][i] == 0 || ma[x][j] == 0)) {
        ansX = x, ansY = j+1;
        return 1;
    }
    //v
    i = j = x, cnt = 0;
    while(ma[i][y] == op && i >= 1) --i, ++cnt;
    for(j = x+1; ma[j][y] == op && j <= 19; ++j) ++cnt;
    if(cnt == 4 && (ma[i][y] == 0 || ma[j][y] == 0)) {
        ansX = i+1, ansY = y;
        return 1;
    }
    //l2r
    i = x, j = y, cnt = 0;
    while(ma[i][j] == op && i <= 19 && j <= 19) ++i, ++j;
    int ii = i--, jj = j--;
    for(; ma[i][j] == op && i >= 1 && j >= 1; --i, --j) ++cnt;
    if(cnt == 4 && (ma[ii][jj] == 0 || ma[i][j] == 0)) {
        ansX = i+1, ansY = j+1;
        return 1;
    }
    //r2l
    i = x, j = y, cnt = 0;
    while(ma[i][j] == op && i <= 19 && j >= 1) ++i, --j;
    ii = i--, jj = j++;
    for(; ma[i][j] == op && i >= 1 && j <= 19; --i, ++j) ++cnt;
    if(cnt == 4 && (ma[ii][jj] == 0 || ma[i][j] == 0)) {
        ansX = i+1, ansY = j-1;
        return 1;
    }
    return 0;
}


int main() {
    //freopen("chess.in", "r", stdin);
    for(int i = 1; i <= 19; ++i) {
        for(int j = 1; j <= 19; ++j) {
            scanf("%d", &ma[i][j]);
        }
    }
    for(int i = 1; i <= 19; ++i) {
        for(int j = 1; j <= 19; ++j) {
            if(ma[i][j] && check(ma[i][j], i, j)) {
                printf("%d:%d,%d", ma[i][j], ansX, ansY);
                return 0;
            }
        }
    }
    puts("No");
    return 0;
}
