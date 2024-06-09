//Luogu P1093 奖学金
#include<iostream>
#include<algorithm>
#include<cstdio>
using namespace std;

const int MAXN=100000;

struct node{
	int ch,ma,en,sc,xh;
	node(int ch = 0, int ma = 0, int en = 0, int sc = 0, int xh = 0):ch(ch), ma(ma), en(en), sc(sc), xh(xh) {};
}stu[MAXN];

inline bool cmp(node x, node y) {
	if(x.sc == y.sc) {
		if(x.ch == y.ch) return x.xh < y.xh;
		return x.ch > y.ch;
	}
	return x.sc > y.sc;
}

int main() {
	int n;
	cin >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> stu[i].ch >> stu[i].ma >> stu[i].en;
		stu[i].xh = i;
		stu[i].sc = stu[i].ch + stu[i].ma + stu[i].en; 
	}
	sort(stu+1, stu+1+n, cmp);
	for(int i = 1; i <= 5 && stu[i].xh; ++i) 
		cout << stu[i].xh << " " << stu[i].sc << endl;
	return 0;
}