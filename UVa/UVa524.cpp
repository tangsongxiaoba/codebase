//UVA524 Prime Ring Problem
#include<iostream>
#include<cstdio>
using namespace std;
int n;
int A[20];
bool vis[20];
bool p[80];

bool is_prime(int x) {
	for(int i = 2; i*i<=x; ++i) {
		if(!(x % i)) return false;
	}
	return true;
}

void dfs(int cur){
	if(cur == n && p[A[0] + A[n-1]]){
		for(int i = 0; i < n; ++i) printf("%d%c", A[i], " \n"[i==n-1]);
	}
	else 
		for(int i = 2; i <= n; ++i)
			if(!vis[i] && p[i + A[cur-1]]) {
				A[cur] = i;
				vis[i] = true;
				dfs(cur+1);
				vis[i] = 0;
			}
}

int main() {
	A[0] = 1;
	for(int i = 2; i <= 80; ++i) p[i] = is_prime(i);
	int i = 1;
	while(cin >> n){
		if(i > 1) printf("\n");
		printf("Case %d:\n",i++);
		dfs(1);
	}	
	return 0;
}