//Luogu P1892 [BOI2003]团伙
#include<cstdio>
#include<iostream>
#define MAXN 4010
using namespace std;

int n,m,fa[MAXN],ans;

int found(int x){
	if(fa[x] == x) return x;
	return fa[x] = found(fa[x]);
}

int main() {
	scanf("%d %d", &n, &m);
	for(int i = 1; i <= n*2+1; ++i) fa[i] = i;
	for(int i = 1; i <= m; ++i) {
		char c;
		int x, y;
		cin >> c;
		scanf("%d %d", &x, &y);
		if(c == 'E') {
			fa[found(x+n)] = found(y);
			fa[found(y+n)] = found(x);
		}
		else {
			fa[found(x)] = found(y);
		}
	}
	for(int i = 1; i <= n; ++i) if(fa[i] == i) ++ans;
	return printf("%d", ans), 0;
} 
