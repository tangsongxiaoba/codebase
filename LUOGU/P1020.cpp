//Luogu P1020 [NOIP1999 ÆÕ¼°×é] µ¼µ¯À¹½Ø
#include<iostream>
#include<cstring>
#include<cstdio>
using namespace std;

const int MAXN = 1e5+10;
int H[MAXN], f[MAXN];
int ans1, ans2;

int main () {
//	int n = 1;
//	for(int ht; cin >> ht; ++n) H[n] = ht;
	while(cin >> H[n++]);
	for(int i = 1; i < n; ++i) {
		f[i] = 1;
		for(int j = 1; j < i; ++j) {
			if(H[j] >= H[i]) f[i] = max(f[i], f[j]+1);
		}
	}
	for(int i = 1; i < n; ++i) ans1 = max(ans1, f[i]);
	memset(f,0,sizeof(f));
	for(int i = 1; i < n; ++i) {
		f[i] = 1;
		for(int j = 1; j < i; ++j) {
			if(H[j] < H[i]) f[i] = max(f[i], f[j]+1);
		}
	}
	for(int i = 1; i < n; ++i) ans2 = max(ans2, f[i]);
	printf("%d\n%d", ans1, ans2);
	return 0;
} 
