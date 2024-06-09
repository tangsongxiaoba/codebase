//UVA11825 Hackers' Crackdown
#include<iostream>
#include<algorithm>
using namespace std;

const int MAXN = 16;
int n, p[MAXN], cover[1<<MAXN], f[1<<MAXN];

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

int main() {
	int k = 0;
	while(cin >> n && n) {
		for(int i = 0; i < n; ++i) {
			int m, x;
			cin >> m;
			p[i] = 1 << i;
			while(m--) {
				cin >> x;
				p[i] |= (1 << x);
			}
		}
		for(int s = 0; s < (1<<n); ++s) {
			cover[s] = 0;
			for(int i = 0; i < n; ++i) {
				if(s & (1 << i))
					cover[s] |= p[i];
			}
		}
		f[0] = 0;
		int ALL = (1<<n) - 1;
		for(int s = 1; s < (1<<n); ++s) {
			f[s] = 0;
			for(int s0 = s; s0; s0 = (s0-1)&s) {
				if(cover[s0] == ALL) gmax(f[s], f[s^s0] + 1); 
			}
		}
		cout << "Case " << ++k << ": " << f[ALL] <<endl;
	}
}