//Luogu P5143 攀爬者
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

struct node{
	int x, y, z;
	node(int x = 0, int y = 0, int z = 0) : x(x), y(y), z(z){};
}spot[50005];

inline bool cmp(node a, node b){
	return a.z < b.z;
} 

inline double dis(node a, node b) {
	return sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y)+(a.z-b.z)*(a.z-b.z));
}

int main() {
	int n;
	double d=0;
	scanf("%d", &n);
	for(int i = 0; i < n; ++i)
		scanf("%d %d %d", &spot[i].x, &spot[i].y, &spot[i].z);
	sort(spot, spot+n, cmp);
	for(int i = 1; i < n; ++i) 
		d += dis(spot[i-1], spot[i]);
	printf("%.3f", d);
	return 0;
}