//P2196 [NOIP1996 提高组] 挖地雷
#include<iostream>
#include<cstdio>
using namespace std;

bool a[30][30];
int w[30];
int f[30];
int rec[30];
int res, pos;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

void dfs(int p) {
    if(rec[p]) dfs(rec[p]);
    printf("%d ", p);
}

int main() {
    int N = read();
    for(register int i = 1; i <= N; ++i) w[i] = read();
    for(register int i = 1; i < N; ++i)
        for(register int j = i+1; j <= N; ++j)
            a[i][j] = a[j][i] = (bool)read();
    f[1] = w[1];
    for(register int i = 2; i <= N; ++i) {
        f[i] = w[i];
        for(register int j = i-1; j > 0; --j) {
            if(a[j][i] && f[i] < f[j] + w[i]) {
                f[i] = f[j] + w[i];
                rec[i] = j;
            }
        }
        if(res < f[i]) {
            res = f[i];
            pos = i;
        }
    }
    dfs(pos);
    printf("\n%d", res);
    return 0;
}