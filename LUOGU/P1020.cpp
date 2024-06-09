//Luogu P1020 [NOIP1999 普及组] 导弹拦截
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;

const int MAXN = 1e5+10;
int a[MAXN], dp1[MAXN], dp2[MAXN], n;

int main() {
    while(scanf("%d", &a[++n]) == 1); --n;
    register int len1 = 1, len2 = 1;
    dp1[1] = dp2[1] = a[1];
    for(register int i = 2; i <= n; ++i) {
        if(dp1[len1] >= a[i]) dp1[++len1] = a[i];
        else *upper_bound(dp1+1, dp1+1+len1, a[i], greater<int>()) = a[i];
        if(dp2[len2] < a[i]) dp2[++len2] = a[i];
        else *lower_bound(dp2+1, dp2+1+len2, a[i]) = a[i];
    }
    printf("%d\n%d", len1, len2);
    return 0;
}