//Luogu P1443 马的遍历
#include<cstdio>
#include<cstring>
#include<queue>

using namespace std;
int map[410][410];

int dx[] = {0,2,1,-1,-2,-2,-1,1,2};
int dy[] = {0,-1,-2,-2,-1,1,2,2,1};

struct node {
	int x, y, step;
	node() {
		step = 0;
	}
};
queue<node> q;

int main () {
	memset(map,-1,sizeof(map));
	int l,m;
	node st;
	scanf("%d %d %d %d", &l, &m, &st.x, &st.y);
	map[st.x][st.y]=0;
	q.push(st);
	
	while(!q.empty()){
		node t = q.front();
		q.pop();
		node n;
		n.step = t.step+1;
		for(int i = 1; i <= 8; ++i) {
			n.x = t.x + dx[i];
			n.y = t.y + dy[i];
			if(n.x >= 1 && n.y >= 1 && map[n.x][n.y] == -1 && n.x <= l && n.y <=m) {
				q.push(n);
				map[n.x][n.y] = n.step;
			}
		}
	}
	for(int i = 1; i <= l; ++i){
		for(int j = 1; j <= m; ++j)
			printf("%-5d", map[i][j]);
		printf("\n");
	}
		
	return 0;
}