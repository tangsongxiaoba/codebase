//P1052 [NOIP2005 提高组] 过河
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
#include<cmath>
using namespace std;

const int MAXN = 1e5+10;
const int INF = 0x3f3f3f3f;
int stone[101], map[MAXN], dp[MAXN];
int s, t, m, p = 0, q, res;

inline void gmin(int &x, const int &y) {
	if(x > y) x = y;
}

int main() {
	int l, k;
	cin >> l >> s >> t >> m;
	for(int i = 1; i <= m; ++i) cin >> stone[i];
	sort(stone+1, stone+m+1);
	for(int i = 1; i <= m; ++i) {
		l = stone[i] - stone[i-1];
		if(!(l % t)) k = t;
		else k = l % t;
		k += t;
		if(l < k) k = l;
		p += k;
		map[p] = 1;
	}
	for(int i = 1; i <= p + t; ++i) {
		res = INF;
		for(int j = i-t; j <= i-s; ++j)
			if(j >= 0) gmin(res, dp[j]);
		dp[i] = res + map[i];
	}
	res = INF;
	for(int i = p+1; i <= p+t; ++i)
		gmin(res, dp[i]);
	cout << res;
	return 0;
}