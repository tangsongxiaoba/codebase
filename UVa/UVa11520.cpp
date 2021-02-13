//UVA11520 Fill the Square
#include<cstdio>
#include<cstring>
using namespace std;

char grid[15][15];
int n;

int main() {
	int T, K = 0;
	scanf("%d", &T);
	while(T--){
		scanf("%d", &n);
		for(int i = 0; i < n; ++i) scanf("%s", grid[i]);
		for(int i = 0; i < n; ++i)
			for(int j = 0; j < n; ++j)
				if(grid[i][j] == '.') {
					for(char ch = 'A'; ch <= 'Z'; ++ch) {
						bool ok = true;
						if((i > 0 && grid[i-1][j] == ch) || (i < n-1 && grid[i+1][j] == ch) || (j > 0 && grid[i][j-1] == ch) || (j < n-1 && grid[i][j+1] == ch)) ok = false;
						if(ok) {
							grid[i][j] = ch;
							break;
						}
					}
				}
		printf("Case %d:\n", ++K);
		for(int i = 0; i < n; ++i)
			printf("%s\n", grid[i]);
	}
	return 0;
}