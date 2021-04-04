//Luogu P1196 银河英雄传说
#include<cstdio>
#include<iostream>
#include<algorithm>
#define MAXN 30010
using namespace std;

int t;

struct node{
	int head, next, len;
	node(int head = 0, int next = 0, int len = 0):head(head), next(next), len(len) {}; 
}q[MAXN];

int fhead(int x) {
	if(q[x].head == x) return x;
	return q[x].head = fhead(q[x].head);
}

int ftail(int x) {
	if(q[x].next == x) return x;
	return q[x].next = (q[x].next);
}

void merge(int x, int y) {
	int hex = fhead(x), tay = ftail(y);
	q[hex].head = tay;
	q[tay].next = hex;
	for(int i=hex; q[i].next!=i; ++i) 
		q[i].len = q[q[i].head].len + 1;
	return;
}

int main() {
//	freopen("in","r",stdin);
	scanf("%d",&t);
	for(int i=1; i <= MAXN; ++i) {
		q[i].head = i;
		q[i].next = i;
	}
	for(int i=1; i <= t; ++i) {
		char c[10] = "";
		int x, y;
		scanf("%s%d%d", c, &x, &y);
		if(c[0] == 'M') {
			merge(x, y);
		}
		else {
			if(fhead(x) != fhead(y)) printf("-1\n");
			else {
				printf("%d\n",abs(q[x].len-q[y].len));
			}
		}
	}
	return 0;
} 