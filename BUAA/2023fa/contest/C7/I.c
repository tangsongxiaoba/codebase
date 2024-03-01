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

short ma[1010][1010], vis[1010][1010];
int h, w;

int dfs(int y, int x) {
    /*write(x), putchar(' '), write(y), puts("");*/
    int ans = 1;
    if(ma[x][y-1] + ma[x][y+1] + ma[x+1][y] == 0) return /*write(x), putchar(' '), write(y), puts(""),*/ x;
    /*if(y > h) return ans;
      else if(x > w) return ans;*/
    if(ma[x][y-1] == 1 && !vis[x][y-1]) {
        vis[x][y-1] = 1;
        int t1 = dfs(y-1, x);
        /*write(t1);
          puts("");*/
        if(t1 > ans) ans = t1;
    }
    if(ma[x][y+1] == 1 && !vis[x][y+1]) {
        vis[x][y+1] = 1;
        int t1 = dfs(y+1, x);
        /*write(t1);
          puts("");*/
        if(t1 > ans) ans = t1;
    }
    if(ma[x+1][y] == 1 && !vis[x+1][y]) {
        vis[x+1][y] = 1;
        int t1 = dfs(y, x+1);
        /*write(t1);
          puts("");*/
        if(t1 > ans) ans = t1;
    }
    if(ma[x-1][y] == 1 && !vis[x-1][y]) {
        vis[x-1][y] = 1;
        int t1 = dfs(y, x-1);
        /*write(t1);
          puts("");*/
        if(t1 > ans) ans = t1;
    }
    /*write(ans);
      puts("");*/
    return ans;
}

int main() {
    h = read();
    w = read();
    int i, j, ans = 1;
    for(i = 1; i <= h; ++i) {
        for(j = 1; j <= w; ++j) {
            ma[i][j] = read();
        }
    }
    for(i = 1; i <= w; ++i) {
        if(ma[1][i] == 1) {
            int t = dfs(i, 1);
            if(t > ans) ans = t;
        }
    }
    printf("%d", ans);
    return 0;
}
