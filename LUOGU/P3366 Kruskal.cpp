//Luogu P3366 【模板】最小生成树
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int MAXN = 5e3+10;
const int MAXM = 2e5+10;
int n, m, e;
int u[MAXM], v[MAXM], w[MAXM];
int p[MAXM], r[MAXM];

inline bool cmp(const int &i, const int &j) {
    return w[i] < w[j];
}

int find(int x) {
    return p[x] == x ? x : p[x] = find(p[x]);
}

inline int kruskal() {
    int ans = 0;
    for(int i = 1; i <= n; ++i) p[i] = i;
    for(int i = 1; i <= m; ++i) r[i] = i;
    sort(r+1, r+1+m, cmp);
    for(int i = 1; i <= m; ++i) {
        int e = r[i];
        int x = find(u[e]);
        int y = find(v[e]);
        if(x != y) {
            ans += w[e];
            p[x] = y;
        }
    }
    return ans;
}

int main() {
    cin >> n >> m;
    for(int i = 1; i <= m; ++i) 
        cin >> u[i] >> v[i] >> w[i];
    cout << kruskal();
    return 0;
}
