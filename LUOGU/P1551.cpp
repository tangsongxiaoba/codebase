//Luogu P1551 亲戚
#include<iostream>
using namespace std;

int n,m,p,fa[6000];

int f(int x){
	if(fa[x] == x) return x;
	return fa[x] = f(fa[x]);
}

int main(){
	int mi,mj;
	cin >> n >> m >> p;
	for(int i = 1; i <= n; ++i) fa[i] = i;
	for(int i = 1; i <= m; ++i) {
		cin >> mi >> mj;
		fa[f(mi)] = fa[f(mj)];
	}
	for(int i = 1; i <= p; ++i) {
		cin >> mi >> mj;
		int ri = f(mi), rj = f(mj);
		if(ri == rj) cout <<"Yes";
		else cout << "No";
		cout << endl;
	}
}
