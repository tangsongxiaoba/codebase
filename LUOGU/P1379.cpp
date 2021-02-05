//Luogu P1379 八数码难题
#include<cstdio>
#include<cstring>
using namespace std;
typedef int State[9];
const int maxstate = 1000000;
State st[maxstate], goal={1,2,3,8,0,4,7,6,5};
int dist[maxstate];
int vis[362880], fact[9];

const int dx[] = {-1,1,0,0};
const int dy[] = {0,0,-1,1};

void init() {
	fact[0] = 1;
	for(int i = 1; i < 9; ++i) fact[i] = fact[i-1] * i;
}

int try_to_insert(int s) {
	int code = 0;
	for(int i = 0; i < 9; ++i) {
		int cnt = 0;
		for(int j = i+1; j < 9; ++j) if(st[s][j] < st[s][i]) ++cnt;
		code += fact[8-i] * cnt;
	}
	if(vis[code]) return 0;
	return vis[code] = 1;
}

int bfs() {
	init();
	int front = 1, rear = 2;
	while(front < rear) {
		State& s = st[front];
		if(memcmp(goal, s, sizeof(s)) == 0) return front;
		int z;
		for(z = 0; z < 9; ++z) if(!s[z]) break;
		int x = z / 3, y = z % 3;
		for(int d = 0; d < 4; ++d) {
			int newx = x + dx[d];
			int newy = y + dy[d];
			int newz = newx*3 + newy;
			if(newx >= 0 && newx < 3 && newy >= 0 && newy < 3) {
				State& t = st[rear];
				memcpy(&t, &s, sizeof(s));
				t[newz] = s[z];
				t[z] = s[newz];
				dist[rear] = dist[front] + 1;
				if(try_to_insert(rear)) ++rear;
			}
		}
		++front;
	}
	return 0;
}

int main() {
	int t;
	scanf("%d", &t);
	for(int i=8; i>=0; --i) {
		st[1][i] = t % 10;
		t /= 10;
	}
	printf("%d\n", dist[bfs()]);
	return 0;
}