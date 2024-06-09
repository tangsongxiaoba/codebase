//UVA10859 Placing Lampposts
#include<cstdio>
#include<iostream>
#include<cstring>
#include<vector>
using namespace std;

vector<int> v[1010];
int vis[1010][2], d[1010][2], n, m;

inline void gmin(int &a, const int &b) {
	if(a > b) a = b;
}

int dp(const int &i, const int &j, const int &f) {
	if(vis[i][j]) return d[i][j];
	vis[i][j] = 1;
	int &ans = d[i][j];
	
	ans = 2000;
	for(int k = 0; k < v[i].size(); ++k) {
		if(v[i][k] != f)
			ans += dp(v[i][k], 1, i);
	}
	if(!j && f >= 0) ++ans;
	if(j || f < 0) {
		int sum = 0;
		for(int k = 0; k < v[i].size(); ++k)
			if(v[i][k] != f)
				sum += dp(v[i][k], 0, i);
		if(f >= 0) ++sum;
		gmin(ans, sum);
	}
	return ans;
}

int main() {
	int T, a, b;
	cin >> T;
	while(T--) {
		cin >> n >> m;
		for(int i = 0; i < n; ++i) v[i].clear();
		for(int i = 0; i < m; ++i) {
			cin >> a >> b;
			v[a].push_back(b);
			v[b].push_back(a);
		}
		memset(vis, 0, sizeof vis);
		int ans = 0;
		for(int i = 0; i < n; ++i)
			if(!vis[i][0])
				ans += dp(i, 0, -1);
		cout << ans/2000 << " " << m-ans%2000 << " " << ans%2000 << endl;
	}
	return 0;
}