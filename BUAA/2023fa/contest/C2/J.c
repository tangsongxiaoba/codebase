#include<stdio.h>
#include<string.h>

const long long MOD = 1e9+7;
int mp[10] = {0, 1, 3, 6, 10, 15, 21, 28, 36, 45};
char s[100009];

int main() {
    int x, i, len;
    long long ans = 0, res = 0;
    scanf("%s", s);
    len = strlen(s);
    for(i = 0; i < len-1; ++i) {
        ans = ((s[i] - '0') + ans * 45) % MOD;
        res += s[i] - '0';
    }
    ans = (mp[s[len-1]-'0'] + ans * 45) % MOD;
    ans = (ans + res) % MOD;
    printf("%lld", ans);

    return 0;
}