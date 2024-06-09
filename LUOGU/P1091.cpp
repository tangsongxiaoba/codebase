//Luogu P1091 [NOIP2004 提高组] 合唱队形
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

const int MAXN = 110;
int n, h[MAXN], ans;
int f[MAXN], g[MAXN];

inline void gmax(int &x, const int &y) {
	if(x < y) x = y;
}

int main() {
	cin >> n;
	for(int i = 1; i <= n; ++i) 
		cin >> h[i];
	for(int i = 1; i <= n; ++i) {
		for(int j = 1; j < i; ++j) 
			if(h[j] < h[i]) gmax(f[i], f[j]);
		++f[i];
	}
	for(int i = n; i; --i) {
		for(int j = n; j > i; --j)
			if(h[j] < h[i]) gmax(g[i], g[j]);
		++g[i];
	}
	for(int i = 1; i <= n; ++i) gmax(ans, f[i] + g[i] - 1);
	cout << n - ans;
	return 0;
}