//Luogu P1120 小木棍 ［数据加强版］
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;

int n, m, a[100], nxt[100], cnt, sum, len;
bool vis[100], flag;

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline bool cmp(const int &a, const int &b) {return a > b;}

void dfs(const int &k, const int &lk, const int &rl) {
    register int i = 1;
    if(!rl) {
        if(k == m) {
            flag = true;
            return;
        }
        for(i = 1; i <= cnt; ++i) if(!vis[i]) break;
        vis[i] = 1;
        dfs(k+1, i, len-a[i]);
        vis[i] = 0;
        if(flag) return;
    }
    register int l = lk+1, r = cnt, mid;
    while(l < r) {
        mid = l + r >> 1;
        if(a[mid] <= rl) r = mid;
        else l = mid+1;
    }
    for(i = l; i <= cnt; ++i) {
        if(!vis[i]) {
            vis[i] = true;
            dfs(k, i, rl - a[i]);
            vis[i] = 0;
            if(flag) return;
            if(rl == a[i] || rl == len) return;
            i = nxt[i];
            if(i == cnt) return;
        }
    }
}

int main() {
    n = read();
    for(register int i = 1; i <= n; ++i) {
        int d = read();
        if(d > 50) continue;
        a[++cnt] = d;
        sum += d;
    }
    sort(a+1, a+cnt+1, cmp);
    nxt[cnt] = cnt;
    for(register int i = cnt - 1; i > 0; --i) {
        if(a[i] == a[i+1]) nxt[i] = nxt[i+1];
        else nxt[i] = i;
    }
    for(len = a[1]; len <= (sum >> 1); ++len) {
        if(sum % len != 0) continue;
        m = sum / len;
        flag = false;
        vis[1] = true;
        dfs(1, 1, len - a[1]);
        vis[1] = false;
        if(flag) {
            printf("%d\n", len);
            return 0;
        }
    }
    printf("%d\n", sum);
    return 0;
}