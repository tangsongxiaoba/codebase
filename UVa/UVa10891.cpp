//UVA10891 Game of Sum
#include<iostream>
#include<algorithm>
#include<cstring>
using namespace std;

int s[110], a[110], d[110][110], n;
int f[110][110], g[110][110];

inline void gmin(int &x, const int &y) {
	if(x > y) x = y;
}

int main() {
	while(cin >> n && n) {
		s[0] = 0;
		for(int i = 1; i <= n; ++i) {
			cin >> a[i];
			s[i] = s[i-1] + a[i];
			f[i][i] = g[i][i] = d[i][i] = a[i];
		}
		for(int l = 1; l < n; ++l) {
			for(int i = 1; i+l <= n; ++i) {
				int j = i+l, m = 0;
				gmin(m, f[i+1][j]);
				gmin(m, g[i][j-1]);
				d[i][j] = s[j] - s[i-1] - m;
				f[i][j] = min(d[i][j], f[i+1][j]);
				g[i][j] = min(d[i][j], g[i][j-1]);
			}
		}
		cout << 2*d[1][n] - s[n] << endl;
	}
}