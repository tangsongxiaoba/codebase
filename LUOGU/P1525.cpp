#include<cstdio>
#include<algorithm>
#define MAXN 200010
using namespace std;

int ans,n,m;
int fa[MAXN];

int found(int a){
	if(fa[a]==a) return a;
	return fa[a]=found(fa[a]);
}

struct node {
	int x, y, c;
//	node(int x=0, int y=0, int c=0):x(x), y(y), c(c) {}
}fought[MAXN];

bool cmp(node a, node b) {
	return a.c > b.c;	
}

int main() {
	freopen("P1525_2.in","r",stdin);
	scanf("%d %d", &n, &m);
	for(int i=1; i<=2*n+1; ++i) fa[i] = i;
	for(int i=1; i<=m; ++i) {
		scanf("%d %d %d", &fought[i].x, &fought[i].y, &fought[i].c);
	}
	sort(fought+1, fought+1+m, cmp);
	
	for(int i=1; i<=m; ++i) {
		if(found(fought[i].x) == found(fought[i].y) || found(fought[i].x + n) == found(fought[i].y + n)){
			ans = fought[i].c;
			break;
		}
		fa[found(fought[i].x)] = found(fought[i].y+n);
		fa[found(fought[i].y)] = found(fought[i].x+n);
	}
	printf("%d\n",ans);
	return 0;
}