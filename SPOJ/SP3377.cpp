//SP3377 BUGLIFE - A Bug's Life
#include<cstdio>
#include<cstring>
using namespace std;
int n,m,fa[3000],d[3000];
char ans1[] = "Suspicious bugs found!";
char ans2[] = "No suspicious bugs found!";

void init(){
	for(int i = 1; i <= n; ++i) fa[i] = i;
	memset(d,0,sizeof(d));
	return; 
}

int f(int x){
	if(fa[x] != x) {
		int t = fa[x];
		fa[x] = f(fa[x]);
		d[x] ^= d[t];
	}
	return fa[x];
}

bool check(int p, int q){
	int rp = f(p), rq = f(q);
	if(rp != rq){
		fa[rq] = rp;
		d[rq] = d[p] ^ d[q] ^ 1;
		return true;
	}
	return false;
}

int main(){
//	freopen("in","r",stdin);
//	freopen("o","w",stdout);
	scanf("%d", &m);
	for(int i = 1; i <= m; ++i) {
		if(i > 1) printf("\n\n");
		int j,b1,b2,flag=0;
		scanf("%d %d", &n, &j);
		init();
		for(int k = 1; k <= j; ++k) {
			scanf("%d %d", &b1, &b2);
			if(!check(b1,b2) && d[b1] ^ d[b2] == 0) flag = 1;
		}
		printf("Scenario #%d:\n",i);
		if(flag) printf("%s",ans1);
		else printf("%s",ans2);
	}
	
	return 0;
} 