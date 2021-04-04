//Luogu P1020 [NOIP1999 普及组] 导弹拦截
#include<iostream>
#include<cstring>
#include<cstdio>
using namespace std;

const int N = 1010, INF = 1 << 30;
int h[N], f[N], d[N];
int n, ans1, ans2;
int main() {
    scanf("%d", &n);
    for(int i = 1; i <= n; ++i) scanf("%d", &h[i]);
    for(int i = 1; i <= n; ++i) {
        for(int j = 1; j < i; ++j) 
            if(h[j] >= h[i]) f[i] = max(f[i], f[j]);
        ++f[i];
    }
    for(int i = 1; i <= n; ++i) ans1 = max(ans1, f[i]);
    for(int i = 1; i <= n; ++i) {
        bool fl = 0; int wh = 0, nowh = INF;
        for(int j = 1; j <= ans2; ++j)
            if(d[j] >= h[i] && d[j] < nowh) nowh = d[j], wh = j;
        if(wh) d[wh] = h[i];
        else d[++ans2] = h[i];
    }
    printf("%d\n%d\n", ans1, ans2);
    return 0;
}