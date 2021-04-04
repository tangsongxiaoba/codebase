//UVA1203/LA3135 Argus
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
	int n, p, t;
	bool operator < (const node &a) const {
		return t > a.t || (t == a.t && n > a.n);
	}
};

priority_queue<node> q;
char s[20];

int main() {
	while(scanf("%s", s) && s[0] != '#') {
		node item;
		scanf("%d%d", &item.n, &item.p);
		item.t = item.p;
		q.push(item);
	}
	
	int k;
	scanf("%d", &k);
	while(k--) {
		node r = q.top();
		q.pop();
		printf("%d\n", r.n);
		r.t += r.p;
		q.push(r);
	}
	return 0;
}