//UVA12124/LA3971 Assemble
#include<iostream>
#include<string>
#include<cstdio>
#include<vector>
#include<map>
using namespace std;

const int MAXN = 1005;
map<string, int> id;
int cnt, n, b;
struct node{
	int p, q;
};
vector<node> comp[MAXN];

int ID(string s) {
	if(!id.count(s)) id[s] = cnt++;
	return id[s];
}

inline void gmin(int &x, const int &y) {
	if(x > y) x = y;
}

inline void gmax(int &x, const int &y) {
	if(x < y) x = y;
}

bool ok(int qi) {
	int sum = 0;
	for(int i = 0; i < cnt; ++i) {
		int c = b+1, m = comp[i].size();
		for(int j = 0; j < m; ++j) {
			if(comp[i][j].q >= qi) 
				gmin(c, comp[i][j].p);
		}
		if(c == b+1) return false;
		sum += c;
		if(sum > b) return false;
	}
	return true;
}

int main() {
	int T;
	cin >> T;
	while(T--) {
		scanf("%d%d", &n, &b);
		cnt = 0;
		for(int i = 0; i < n; ++i) 
			comp[i].clear();
		id.clear();
		int maxq = 0;
		for(int i = 0; i < n; ++i) {
			char type[30], name[30];
			int p1, q1;
			scanf("%s%s%d%d", type, name, &p1, &q1);
			gmax(maxq, q1);
			comp[ID(type)].push_back((node){p1, q1});
		}
		int L = 0, R = maxq;
		while(L < R) {
			int M = L + (R-L+1)/2;
			if(ok(M)) L = M;
			else R = M-1;
		}
		cout << L <<endl;
	}
	return 0;
}