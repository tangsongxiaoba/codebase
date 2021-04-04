//Luogu P1156 垃圾陷阱
#include<iostream>
#include<cstring>
#include<algorithm>
#include<cstdio>
using namespace std;

const int MAXN = 105;
int D, G, delta, ans;
int f[MAXN][200];

struct node {
	int T, F, H;
	bool operator < (const node &x) const {
		return T < x.T;
	}
} a[MAXN];

void getMax(int &x, const int &y) {
	if (x < y) x = y;
}

int main () {
	cin >> D >> G;
	for(int i = 1; i <= G; ++i) {
		cin >> a[i].T >> a[i].F >> a[i].H;
	}
	sort(&a[1], &a[G+1]);
	memset(f, -1, sizeof(f));
	f[0][0] = 10;
	for(int i = 1; i <= G; ++i) {
		delta = a[i].T - a[i-1].T;
		for(int j = 0; j <= D; ++j) {
			if(f[i-1][j] >= delta) 
				getMax(f[i][j], f[i-1][j] - delta + a[i].F);
			getMax(f[i][j+a[i].H], f[i-1][j] - delta);
		}
		if(f[i][D] >= 0) {
			cout << a[i].T;
			return 0;
		}
	}
	for(int i = 1; i <= G; ++i) {
		for(int j = 0; j < D; ++j) {
			if(f[i][j] != -1) {
				getMax(ans, a[i].T + f[i][j]);
			}
		}
	}
	cout << ans;
	return 0;
} 