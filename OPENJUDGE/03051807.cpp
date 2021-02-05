//OpenJudge 03051807 Õý·½ÐÎ 
#include<iostream>
#include<vector>
#include<cstdio>
using namespace std;

const int HASH_MOD = 19260817;
int n;
vector<node> v[HASH_MOD];
struct node{
	int x, y;
	node(int x = 0, int y = 0):x(x), y(y){};
}spot[1010];

inline int Hash(node a) {
	return (a.x*a.x + a.y*a.y) % HASH_MOD;
} 

inline void Push(node a) {
	v[Hash(a)].push_back(a);
}

int main() {
	while(1) {
		scanf("%d", &n);
		if(!n) return 0;
		for(int i = 0; i < n; ++i) 
			scanf("%d %d", &spot[i].x, &spot[i].y);
		for(int i = 0; i < n; ++i)
			Push(spot[i]); 
		for(int i = 0; i < n; ++i) {
			
		}
	}
}
