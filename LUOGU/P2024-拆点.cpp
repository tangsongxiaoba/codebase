//luogu P2024 食物链 拆点并查集
#include<cstdio>
using namespace std;

int n,k,fa[200000],ans;

int find(int x) {
	if(fa[x] == x) return x;
	return fa[x] = find(fa[x]);
}

void merge(int x, int y) {
	fa[find(x)] = find(y);
}

int main() {
	scanf("%d%d", &n, &k);
	for(int i = 1; i <= 3*n + 1; ++i) {
		fa[i] = i;
	}
	int d,x,y;
	for(int i = 0; i < k; ++i) {
		scanf("%d%d%d", &d, &x, &y);
		if(x > n || y > n) {
			++ans;
			continue;
		}
		else{
			if(d == 1){
				if( find(x + n) == find(y) || find(y + n) == find(x) ) {
					++ans;
					continue;
				}
				merge(x, y);
				merge(x+n, y+n);
				merge(x+2*n, y+2*n);
			}
			else {
				if(x == y) {
					++ans;
					continue;
				}
				if(find(x) == find(y) || find(x) == find(y+n) ) {
					++ans;
					continue;
				}
				else {
					merge(x+n, y);
					merge(x+n*2, y+n);
					merge(x,y+n*2);
				}
			}
		}
	}
	printf("%d", ans);
	return 0;
}