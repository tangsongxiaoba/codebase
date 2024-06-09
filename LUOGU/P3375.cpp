//P3375 【模板】KMP字符串匹配
#include<iostream>
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 1e6+10;
char T[MAXN], P[MAXN];
int nxt[MAXN];
int n, m, j;

int main() {
    scanf("%s%s", T+1, P+1);
    n = strlen(T+1), m = strlen(P+1);
    for(int i = 2; i <= m; ++i) {
        while(j > 0 && P[i] != P[j+1]) j = nxt[j];
        if(P[j+1] == P[i]) ++j;
        nxt[i] = j;
    }
    j = 0;
    for(int i = 1; i <= n; ++i) {
        while(j > 0 && P[j+1] != T[i]) j = nxt[j];
        if(P[j+1] == T[i]) ++j;
        if(j == m) printf("%d\n", i-m+1), j = nxt[j];
    }
    for(int i = 1; i <= m; ++i) printf("%d ", nxt[i]);
    return 0;
}