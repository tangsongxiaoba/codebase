//Luogu P2294 [HNOI2005]狡猾的商人
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
using namespace std;

const int MAXN = 4e3+10;
int fa[MAXN], s[MAXN];
int T, n, m;
bool flag;

int findFa(int x) {
	if(x != fa[x]) {
		int t = fa[x];
		fa[x] = findFa(fa[x]);
		s[x] += s[t];
	}
	return fa[x];
}
int u, v, w, fu, fv;

int main() {
	cin >> T;
	while(T--) {
		flag = true;
		cin >> n >> m;
		for(int i = 0; i <= n; ++i) {
			fa[i] = i;
			s[i] = 0;
		}
		for(int i = 1; i <= m; ++i) {
			cin >> u >> v >> w;
			--u;
			if(!flag) continue;
			fu = findFa(u);
			fv = findFa(v);
			if(fu != fv) {
				fa[fu] = fv;
				s[fu] = s[v] - s[u] + w;
			}
			else {
				if(s[u] - s[v] != w) {
				flag = false;
				cout << "false" << endl;
				}
			}
		}
		if(flag) cout << "true" <<endl;
	}
	return 0;
}