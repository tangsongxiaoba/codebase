//UVA10881 Piotr's Ants
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;

const int MAXN = 1e4+5;
const char st[][10] = {"L", "Turning", "R"};
int ord[MAXN];

struct node{
	int id, p, d;
	bool operator < (const node &a) const {
		return p < a.p;
	}
}before[MAXN], after[MAXN];

int main() {
	int K;
	cin >> K;
	for(int k = 1; k <= K; ++k) {
		int L, T, n;
		printf("Case #%d:\n", k);
		cin >> L >> T >> n;
		for(int i = 0; i < n; ++i) {
			int p, d;
			char c;
			cin >> p >> c;
			d = (c == 'L' ? -1 : 1);
			before[i] = (node){i, p, d};
			after[i] = (node){0, p+T*d, d};
		}
		sort(before, before+n);
		for(int i = 0; i < n; ++i)
			ord[before[i].id] = i;
		sort(after, after+n);
		for(int i = 0; i < n-1; ++i)
			if(after[i].p == after[i+1].p)
				after[i].d = after[i+1].d = 0;
		for(int i = 0; i < n; ++i) {
			int a = ord[i];
			if(after[a].p < 0 || after[a].p > L) printf("Fell off\n");
			else printf("%d %s\n", after[a].p, st[after[a].d+1]);
		}
		cout << endl;
	}
	return 0;
}
