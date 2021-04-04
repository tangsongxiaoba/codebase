//P2661 [NOIP2015 提高组] 信息传递
#include<cstdio>
#include<iostream>
using namespace std;

int n,t,fa[200010],d[200010],res;

void init() {
	for(int i = 1; i <= n; ++i) fa[i] = i;
	res = 0x7FFFFFFF;
}

int findFa(int x) {
	if(fa[x] == x) return x;
	else{
		int t = fa[x];
		fa[x] = findFa(fa[x]);
		d[x] += d[t];
	}
	return fa[x];
}

void check(int p, int q) {
	int rp = findFa(p), rq = findFa(q);
	if(rp != rq){
		fa[rp] = rq;
		d[p] = d[q] + 1;
	}
	else res = min(res, d[p] + d[q] + 1);
	return;
}

int main() {
	scanf("%d", &n);
	init();
	for(int i = 1; i <=n ; ++i) {
		scanf("%d", &t);
		check(i,t);
	}
	printf("%d",res);
	return 0;
} 
