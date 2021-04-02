//P1709 [USACO5.5]隐藏口令Hidden Password
#include<cstdio>
using namespace std;

const int MAXN = 5e6+10;
int n;
char s[MAXN];

int main() {
    scanf("%d", &n);
    for(register int i = 0; i < n;) {
        register char c = getchar();
        if(c == ' ' || c == '\r' || c == '\n' || c == EOF) continue;
        s[i++] = c;
    }
    register int x = 0, y = 1, k = 0;
    while(x < n && y < n) {
        k = 0;
        while((s[(x+k)%n] == s[(y+k)%n]) && k < n) ++k;
        if(k == n) break;
        if(s[(x+k)%n] > s[(y+k)%n]) x += k + 1;
        else y += k + 1;
        if(x == y) ++y;
    }
    printf("%d", (x < y) ? x : y);
}