//UVA11729 Commando War
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
#include<stack>
#include<map>
using namespace std;

struct node{
	int j, b;
	node(int j, int b):j(j), b(b) {}
	inline bool operator < (const node &x) const {
		return j > x.j;
	}
};

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

int main() {
	int n, b, j, k = 1;
	while(scanf("%d", &n) == 1 && n) {
		vector<node> v;
		for(int i = 0; i < n; ++i) {
			scanf("%d%d", &b, &j);
			v.push_back(node(j, b));
		}
		sort(v.begin(), v.end());
		int s = 0, ans = 0;
		for(int i = 0; i < n; ++i) {
			s += v[i].b;
			gmax(ans, s+v[i].j);
		}
		printf("Case %d: %d\n", k++, ans);
	}	
	return 0;
}