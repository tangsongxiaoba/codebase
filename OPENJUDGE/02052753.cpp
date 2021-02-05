//OpenJudge 02052753 走迷宫
#include<cstdio>
#include<queue>
#define P pair<int,int>

using namespace std;

int dx[] = {0,1,0,-1,0};
int dy[] = {0,0,1,0,-1};

queue<P> q1,q2;
int dis[45][45],vis[45][45];
int r,c;
char m[45][45];

int main(){
	int sx,sy;
	scanf("%d%d",&r,&c);
	for(int i = 1; i<=r; ++i)
		scanf("%s",&m[i]);
	dis[1][1] = dis[r][c] = 1;
	vis[1][1] = 1;
	vis[r][c] = 2;
	q1.push(P(1,1));
	q2.push(P(r,c));
	bool flag;
	while(!q1.empty() && !q2.empty()){
		int tx,ty;
		if(q1.size()>q2.size()){
			tx = q1.front().first;
			ty = q1.front().second;
			q1.pop();
			flag = true;
		}
		else{
			tx = q2.front().first;
			ty = q2.front().second;
			q2.pop();
			flag = false;
		}
		for(int i=1; i<=4; ++i){
			int nx = tx+dx[i];
			int ny = ty+dy[i];
			if(nx < 1 || ny < 1 || nx > r || ny > c) continue;
			if(m[nx][ny] != '.') continue;
			if(!dis[nx][ny]){
				dis[nx][ny] = dis[tx][ty] +1;
				vis[nx][ny] = vis[tx][ty];
				if(flag) q1.push(P(nx,ny));
				else q2.push(P(nx,ny));
			}
			else if(vis[nx][ny] + vis[tx][ty] == 3){
				printf("%d", dis[nx][ny]+dis[tx][ty]);
				return 0;
			}
		}
	}
	
	return 0;
}