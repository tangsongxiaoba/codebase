//UVA11464 Even Parity
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
#include<stack>
#include<map>
using namespace std;

const int MAXN = 20;
const int INF = 1e9;
int n, a[MAXN][MAXN], b[MAXN][MAXN];

int check(int s) {
	memset(b, 0, sizeof b);
	for(int c = 0; c < n; ++c) {
		if(s & (1 << c)) b[0][c] = 1;
		else if(a[0][c] == 1) return INF;
	}
	for(int r = 1; r < n; ++r) 
		for(int c = 0; c < n; ++c) {
			int sum = 0;
			if(r > 1) sum += b[r-2][c];
			if(c > 0) sum += b[r-1][c-1];
			if(c < n-1) sum += b[r-1][c+1];
			b[r][c] = sum % 2;
			if(a[r][c] == 1 && b[r][c] == 0) return INF;
		}
	int cnt = 0;
	for(int r = 0; r < n; ++r) 
		for(int c = 0; c < n; ++c) if(a[r][c] != b[r][c]) ++cnt;
	return cnt;
}

inline void gmin(int &a, const int &b) {
	if(a > b) a = b;
}

int main() {
	int T;
	cin >> T;
	for(int k = 1; k <= T; ++k) {
		cin >> n;
		for(int r = 0; r < n; ++r)
			for(int c = 0; c < n; ++c)
				scanf("%d", &a[r][c]);
		int ans = INF;
		for(int s = 0; s < (1<<n); ++s)
			gmin(ans, check(s));
		if(ans == INF) ans = -1;
		printf("Case %d: %d\n", k, ans);
	}
	return 0;
}