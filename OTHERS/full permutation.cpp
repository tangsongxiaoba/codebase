//full permutation
#include<cstdio>
using namespace std;

int a[10000];
bool vis[10000];
int n;

void dfs(int x){
	if(x == n+1){
		for(int i = 1; i<=n; ++i) printf("%5d", a[i]);
		printf("\n");
		return;
	}
	for(int i = 1; i<=n; ++i){
		if(!vis[i]){
			a[x] = i;
			vis[i] = true;
			dfs(x+1);
			vis[i] = false;
		}
	}
}

int main() {
	scanf("%d",&n);
	dfs(1);
	return 0;
}