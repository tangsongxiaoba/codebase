//UVA1160/LA3644 X-Plosives
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
using namespace std;

const int MAXN = 1e5+10;
int pa[MAXN];

int findset(int x) {
	return pa[x] != x ? pa[x] = findset(pa[x]) : x;
}

int main() {	
	int x, y;
	while(scanf("%d", &x) == 1) {
		for(int i = 0; i <= MAXN; ++i) pa[i] = i;
		int refusals = 0;
		while(x != -1) {
			scanf("%d", &y);
			x = findset(x), y = findset(y);
			if(x == y) ++refusals;
			else pa[x] = y;
			scanf("%d", &x);
		}
		printf("%d\n", refusals);
	}
		
	return 0;
}