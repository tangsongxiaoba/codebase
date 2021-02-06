//UVA129 Krypton Factor
#include<cstdio>
#include<iostream>

using namespace std;

int n,cnt,L;
int S[2000];

int dfs(int cur) {
	if(cnt++ == n) {
		for(int i = 0; i < cur; ++i) {
			if(i % 64 == 0 && i != 0) printf("\n");
			else if(i != 0 && i % 4 == 0) printf(" ");
			printf("%c", 'A'+S[i]);
		}
		printf("\n%d\n", cur);
		return 0;
	}
	for(int i = 0; i < L; ++i) {
		S[cur] = i;
		int ok = 1;
		for(int j = 1; j*2 <= cur+1; ++j) {
			int equal = 1;
			for(int  k = 0; k < j; ++k)
				if(S[cur-k] != S[cur-k-j]) {
					equal = 0;
					break;
				}
			if(equal) {
				ok = 0;
				break;
			}
		}
		if(ok) if(!dfs(cur+1)) return 0;
	}
	return 1;
}

int main() {
//	freopen("c.in","r",stdin);
//	freopen("c.out","w",stdout);
	int i = 1;
	while(cin >> n >> L) {
		if( n == 0 && L == 0 )break;
		cnt = 0;
		dfs(0);
		++i;
	}
	return 0;
}