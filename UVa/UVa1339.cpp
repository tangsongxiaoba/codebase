// UVa1339 Ancient Cipher
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;

char s1[200], s2[200];

int main() {
    while(scanf("%s%s", s1, s2) == 2) {
        register int n = strlen(s1);
        register int cnt1[26] = {0}, cnt2[26] = {0};
        for(register int i = 0; i < n; i++) ++cnt1[s1[i] - 'A'];
        for(register int i = 0; i < n; i++) ++cnt2[s2[i] - 'A'];
        sort(cnt1, cnt1 + 26);
        sort(cnt2, cnt2 + 26);
        register int ok = 1;
        for(register int i = 0; i < 26; i++)
            if(cnt1[i] != cnt2[i]) ok = 0;
        if(ok) printf("YES\n");
        else printf("NO\n");
    }
    return 0;
}
