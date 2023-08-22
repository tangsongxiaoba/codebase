//Luogu P2024 食物链
#include<cstdio>
using namespace std;

int v[50010], fa[50010], n, k, x, y, d, cnt;

int findFa(int x) {
	if(x != fa[x]) {
		int t = findFa(fa[x]);
		v[x] = (v[x] + v[fa[x]]) % 3;
		fa[x] = t;
	}
	return fa[x];
}

int main(){
	scanf("%d %d", &n, &k);
	for(int i=1; i <= n; ++i){
		fa[i] = i;
	}
	for(int i = 1; i <= k; ++i){
		scanf("%d %d %d", &d, &x, &y);
		if(x > n || y > n) ++cnt;
		else if(d == 1){
			if(findFa(x) == findFa(y)){
				if(v[x] != v[y]) ++cnt;
			}
			else{
				v[fa[x]] = (v[y] - v[x] + 3) % 3;
				fa[fa[x]] = fa[y];
			}
		}
		else{
			if (x!=y)
				if (findFa(x)==findFa(y))
					cnt+=v[x]!=(v[y]+1)%3; 
				else
				{
					v[fa[x]]=(v[y]+1-v[x]+3)%3;
					fa[fa[x]]=fa[y];
				}
			else ++cnt;
		}
	}
	printf("%d", cnt);
	return 0;
}