//Luogu P1996 约瑟夫问题
#include<cstdio>
using namespace std;

bool vis[200];
int n, m, s;

int main() {
    scanf("%d%d", &n, &m);
    for(int k = 0; k < n; ++k) {
        for(int i = 0; i < m; ++i) {
            if(++s > n) s = 1;
            if(vis[s]) i--;
        }
        printf("%d ", s);
        vis[s] = true;
    }
    return 0;
}