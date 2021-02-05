//Luogu P2814 家谱
#include<iostream>
#include<cstdio>
#include<map>
#include<string>
using namespace std;

const int MAXN = 5e5;
map<string, string> fa;
char opt;
string tmp, f;

string findFa(string x) {
	if(x == fa[x]) return x;
	else return fa[x] = findFa(fa[x]);
}

int main() {
	scanf("%c", &opt);
	while(opt != '$') {
		cin >> tmp;
		if(opt == '#') {
			f = tmp;
			if(fa[tmp] == "") fa[tmp] = tmp;
		}
		else if(opt == '+') fa[tmp] = f;
		else cout << tmp << " " << findFa(tmp) << endl;
		scanf("\n%c", &opt);
	}
	return 0;
}