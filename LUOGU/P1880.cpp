//Luogu P1880 [NOI1995] 石子合并
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

int dp1[220][220], dp2[220][220];
int s[220], v[220];
int n;

inline int d(const int &a, const int &b) {
	return s[a] - s[b-1];
}

inline void gmin(int &a, const int &b) {
	if(a > b) a = b;
}

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

int main() {
	cin >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> v[i];
		v[i+n] = v[i];
	}
	for(int i = 1; i <= (n<<1); ++i ) s[i] = s[i-1] + v[i];
	for(int l = 1; l <= n; ++l) {
		for(int j = 1; j + l <= (n << 1); ++j) {
			int ed = j + l - 1;
			dp2[j][j+l] = 0x3f3f3f3f;
			for(int i = j; i < ed; ++i) {
				gmin(dp2[j][ed], dp2[j][i] + dp2[i+1][ed] + d(ed, j));
				gmax(dp1[j][ed], dp1[j][i] + dp1[i+1][ed] + d(ed, j));
			}
		}
	}
	int ansmin = 0x3f3f3f3f;
	int ansmax = -1;
	for(int i = 1; i <= n; ++i) {
		gmin(ansmin, dp2[i][i+n-1]);
		gmax(ansmax, dp1[i][i+n-1]);
	}
	cout << ansmin << endl;
	cout << ansmax;
	return 0;             
}