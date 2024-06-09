//UVA1030/LA2995 Image Is Everything
#include<iostream>
#include<cstdio>
#include<cstring>
#include<cmath>
#include<algorithm>
using namespace std;

int n;
char pos[10][10][10];
char view[6][10][10];

inline char rch() {
	char ch;
	for(;;) {
		ch = getchar();
		if((ch >= 'A' && ch <= 'Z') || ch == '.') {
			return ch;
		}
	}
}

inline void get(const int &k, const int &i, const int &j, const int &len, int &x, int &y, int &z) {
	switch(k) {
		case 0:
			x = len, y = j, z = i;
			break;
		case 1:
			x = n-1-j, y = len, z = i;
			break;
		case 2:
			x = n-1-len, y = n-1-j, z = i;
			break;
		case 3:
			x = j, y = n-1-len, z = i;
			break;
		case 4:
			x = n-1-i, y = j, z = len;
			break;
		case 5:
			x = i; y = j; z = n-1-len;
			break;
	}
}

int main() {
	while(cin >> n && n) {
		for(int i = 0; i < n; ++i) 
			for(int k = 0; k < 6; ++k)
				for(int j = 0; j < n; ++j)
					view[k][i][j] = rch();
		for(int i = 0; i < n; ++i)
		    for(int j = 0; j < n; ++j)
				for(int k = 0; k < n; ++k)
					pos[i][j][k] = '#';
		for(int k = 0; k < 6; ++k)
			for(int i = 0; i < n; ++i)
				for(int j = 0; j < n; ++j)
					if(view[k][i][j] == '.')
						for(int p = 0; p < n; ++p) {
							int x, y, z;
							get(k, i, j, p, x, y, z);
							pos[x][y][z] = '.';
						}
		for(; ; ) {
			bool done = true;
			for(int k = 0; k < 6; ++k)
				for(int i = 0; i < n; ++i)
					for(int j = 0; j < n; ++j)
						if(view[k][i][j] != '.') {
							for(int p = 0; p < n; ++p) {
								int x, y, z;
								get(k, i, j, p, x, y, z);
								if(pos[x][y][z] == '.') continue;
								if(pos[x][y][z] == '#') {
									pos[x][y][z] = view[k][i][j];
									break;
								}
								if(pos[x][y][z] == view[k][i][j]) break;
								pos[x][y][z] = '.';
								done = false;
							}
						}
						if(done) break;
		}
		
		int ans = 0;
		for(int i = 0; i < n; ++i)
			for(int j = 0; j < n; ++j)
				for(int k = 0; k < n ; ++k)
					if(pos[i][j][k] != '.') ++ans;
		printf("Maximum weight: %d gram(s)\n", ans);
	}
	return 0;
}