//Luogu P1219 八皇后问题
#include <cstdio>
using namespace std;

int C[20];
int tot,n;

void print() {
	for(int i = 0; i < n; ++i) 
		printf("%d ", C[i]);
	printf("\n");
	return;
}

void search(int cur, int col, int cro1, int cro2) {
	if(cur == n){
		++tot;
		if(tot < 4) print();
	}
	else{
		int s = col | cro1 | cro2;
		for(int i = 0; i < n; ++i) {
			if(s & (1 << i)) continue;
			C[cur] = i+1;
			search(cur+1, col | (1 << i), (cro1 | (1 << i) ) << 1, (cro2 | (1 << i)) >> 1);
		}
	}
}

int main(){
	tot=0;
	scanf("%d", &n);
	search(0,0,0,0);
	printf("%d",tot);
	
	return 0;
}
