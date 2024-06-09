//UVA11997 K Smallest Sums
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

const int MAXN = 768;
int A[MAXN][MAXN];

struct node{
	int s, b;
	node(int s, int b):s(s), b(b) {}
	inline bool operator < (const node &a) const {
		return s > a.s;
	}
};

void merge(int *a, int *b, int *c, int n) {
	priority_queue<node> q;
	for(int i = 0; i < n; ++i) 
		q.push(node(a[i]+b[0], 0));
	for(int i = 0; i < n; ++i) {
		node item = q.top();
		q.pop();
		c[i] = item.s;
		int x = item.b;
		if(x+1 < n) q.push(node(item.s-b[x]+b[x+1], x+1));
	}
}

int main() {
	int n;
	while(scanf("%d", &n) == 1) {
		for(int i = 0; i < n; ++i) {
			for(int j = 0; j < n; ++j) 
				scanf("%d", &A[i][j]);
			sort(A[i], A[i]+n);
		}
		for(int i = 1; i < n; ++i) 
			merge(A[0], A[i], A[0], n);
		printf("%d", A[0][0]);
		for(int i = 1; i < n; ++i) 
			printf(" %d", A[0][i]);
		printf("\n");
	}
	return 0;
}