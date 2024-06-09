//Luogu P1352 没有上司的舞会
#include<iostream>
#include<cmath>
#include<vector>
#include<cstdio>
using namespace std;

const int MAXN = 6e3+10;
vector<int> s[MAXN];
int n, root, h[MAXN];
bool v[MAXN];
int f[MAXN][2];

void dp (int x) {
	f[x][0] = 0;
	f[x][1] = h[x];
	for(int i = 0; i < s[x].size(); ++i) {
		int y = s[x][i];
		dp(y);
		f[x][0] += max(f[y][0], f[y][1]);
		f[x][1] += f[y][0];
	}
}

int main () {
	cin >> n;
	for(int i = 1; i <= n; ++i) cin >> h[i];
	for(int i = 1; i < n; ++i) {
		int l, k;
		cin >> l >> k;
		s[k].push_back(l);
		v[l] = true;
	}
	for(int i = 1; i <= n; ++i) {
		if(!v[i]) {
			root = i;
			break;
		} 
	}
	dp(root);
	cout << max(f[root][0], f[root][1]) << endl;
	return 0;
} 