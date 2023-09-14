#include <iostream>
using namespace std;

char map[110][110];
int res[110][110];

int main() {
    int m, n;
    cin >> m >> n;
    for(int i = 1; i <= m; ++i) {
        scanf("%s", map[i]+1);
    }
    for(int i = 1; i <= m; ++i) {
        for(int j = 1; j <= n; ++j) {
            if(map[i][j] == '*') {
                res[i][j] = -1;
                ++res[i-1][j-1], ++res[i][j-1], ++res[i+1][j-1], ++res[i-1][j], ++res[i-1][j+1], ++res[i+1][j+1], ++res[i+1][j], ++res[i][j+1]; 
            }
        }
    }
    for(int i = 1; i <= m; ++i) {
        for(int j = 1; j <= n; ++j) {
            if(map[i][j] == '*') putchar('*');
            else printf("%d", res[i][j]);
        }
        puts("");
    }
    return 0;
}