//Luogu P1309 瑞士轮
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;

const int MAXN = 2e6;
int n, r, q;
struct node{
	int sc, po, ord;
	node(int sc = 0, int po = 0, int ord = 0) : sc(sc), po(po), ord(ord) {};
	bool operator < (const node &t) const {
		if(sc == t.sc) return ord < t.ord;
		return sc > t.sc;
	}
}player[MAXN], Winner[MAXN], Loser[MAXN];

int main() {
	scanf("%d%d%d", &n, &r, &q);
	for(int i = 1; i <= 2*n; ++i) {
		scanf("%d", &player[i].sc);
		player[i].ord = i;
	}
	for(int i = 1; i <= 2*n; ++i)
		scanf("%d", &player[i].po);
	sort(player+1, player+2*n+1);
	for(int i = 1; i <= r; ++i) {
		for(int i = 1; i <= n; ++i) {
			if(player[i*2-1].po < player[i*2].po) {
				++player[i*2].sc;
				Winner[i] = player[i*2];
				Loser[i] = player[i*2-1];
			} 
			else {
				++player[i*2-1].sc;
				Winner[i] = player[i*2-1];
				Loser[i] = player[i*2];
			}
		}
		merge(Loser+1, Loser+n+1, Winner+1, Winner+n+1, player+1);
	}
	printf("%d", player[q].ord);
	return 0;
} 
