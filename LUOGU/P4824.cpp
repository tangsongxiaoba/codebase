//Luogu 4824 [USACO15FEB]Censoring S
#include<cstdio>
#include<cstring>
#define MAXN 1000010
using namespace std;

int n, m, res;
char s1[MAXN], s2[MAXN];
int p1[MAXN], p2[MAXN];
int S[MAXN], top;

int main() {
    scanf("%s", s1+1);
    scanf("%s", s2+1);
    n = strlen(s1+1);
    m = strlen(s2+1);
    for(register int i = 2, j = 0; i <= m; ++i) {
        while(j && s2[i] != s2[j+1]) j = p1[j];
        if(s2[i] == s2[j+1]) ++j;
        p1[i] = j;
    }
    for(register int i = 1, j = 0; i <= n; ++i) {
        while(j && s1[i] != s2[j+1]) j = p1[j];
        if(s1[i] == s2[j+1]) ++j;
        p2[i] = j;
        S[++top] = i;
        if(j == m) top -= m, j = p2[S[top]];
    }
    for(register int i = 1; i <= top; ++i) printf("%c", s1[S[i]]);
    return 0;
}