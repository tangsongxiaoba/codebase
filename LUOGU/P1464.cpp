//Luogu P1464 Function
#include<iostream>
#include<cstdio>
using namespace std;

long long dp[30][30][30];

inline long long w(const long long &a, const long long &b, const long long &c) {
    if(a <= 0 || b <= 0 || c <= 0) return 1;
    if(a > 20 || b > 20 || c > 20) return w(20, 20, 20);
    if(a < b && b < c && !dp[a][b][c]) dp[a][b][c] = w(a, b, c-1) + w(a, b-1, c-1) - w(a, b-1, c);
    else if(!dp[a][b][c]) dp[a][b][c] = w(a-1, b, c) + w(a-1, b-1, c) + w(a-1, b, c-1) - w(a-1, b-1, c-1);
    return dp[a][b][c];
}

int main() {
    long long a, b, c;
    while(cin >> a >> b >> c && (a != -1 || b != -1 || c != -1))
        printf("w(%d, %d, %d) = %d\n", a, b, c, w(a, b, c));
    return 0;
}