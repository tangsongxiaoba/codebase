//Luogu P1197 [JSOI2008]星球大战
#include<iostream>
#include<cstdio>
#include<vector>
using namespace std;

const int MAXN = 2e5+7;
int n, m, k, res;
int target[MAXN*2];
bool planet[MAXN*2];
int fa[MAXN*2];
int ans[MAXN*2]; 
vector<int> tunnel[MAXN*2];

int Find(int x) {
	if(fa[x] == x) return x;
	return fa[x] = Find(fa[x]); 
}

int main() {
	scanf("%d%d", &n, &m);
	for(int i = 0; i < n; ++i) fa[i] = i;
	int x, y;
	for(int i = 0; i < m; ++i) {
		scanf("%d%d", &x, &y);
		tunnel[x].push_back(y);
		tunnel[y].push_back(x);
	}
	scanf("%d", &k);
	res = n - k;
	for(int i = 0; i < k; ++i) {
		scanf("%d", &target[i]);
		planet[target[i]] = true;
	}
	for(int i = 0; i < n; ++i) {
		x = i;
		for(int j = 0; j < tunnel[x].size(); ++j) {
			y = tunnel[x][j];
			if((!planet[x] && !planet[y]) && (Find(x) != Find(y))){
				fa[Find(x)] = Find(y), --res;
			}
		}
	}
	ans[k] = res;
	for(int i = k-1; i >= 0; --i) {
		x = target[i], ++res;
		for(int j = 0; j < tunnel[x].size(); ++j) {
			y = tunnel[x][j];
			if(!planet[y] && Find(x) != Find(y)) {
				fa[Find(x)] = Find(y);
				--res;
			}
		}
		planet[x] = false;
		ans[i] = res;
	}
	for(int i = 0; i <= k; ++i) printf("%d\n", ans[i]);
	return 0;
}