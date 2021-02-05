//Luogu P1665 正方形计数
#include<iostream>
#include<vector>
#include<cstdio>
using namespace std;

const int HASH_MOD = 1009;
int n, cnt;
struct node{
	int x, y;
}spot[550], n1, n2;
vector<node> v[HASH_MOD];

inline int Hash(node a) {
	return (a.x*a.x + a.y*a.y) % HASH_MOD;
}

inline void Push(node a) {
	v[Hash(a)].push_back(a);
}

inline bool Find(node a) {
	int h = Hash(a), len = v[h].size();
	for(int i = 0; i < len; ++i) 
		if(v[h][i].x == a.x && v[h][i].y == a.y) return true;
	return false;
}

int main() {
	scanf("%d", &n);
	for(int i = 0; i < n; ++i) {
		scanf("%d%d", &spot[i].x, &spot[i].y);
		spot[i].x = (spot[i].x + 51) << 1;
		spot[i].y = (spot[i].y + 51) << 1;
		Push(spot[i]);
	}
	for(int i = 0; i < n; ++i) {
		for(int j = 0; j < n; ++j) {
			if(i == j) continue;
			n1.x = (spot[i].x + spot[i].y + spot[j].x - spot[j].y) / 2;
			n1.y = (0 - spot[i].x + spot[i].y + spot[j].x + spot[j].y) / 2;
			n2.x = (spot[i].x - spot[i].y + spot[j].x + spot[j].y) / 2;
			n2.y = (spot[i].x + spot[i].y - spot[j].x + spot[j].y) / 2;
			if(Find(n1) && Find(n2)) ++cnt;
		}
	}
	printf("%d", cnt/4);
	return 0;
}