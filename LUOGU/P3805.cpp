//Luogu P3805 【模板】manacher 算法
#include<bits/stdc++.h>
using namespace std;
#define maxn 11000010

string a, ma;
vector<int> pa;

int main() {
    cin >> a;
    if(a.length() == 0) return puts("0"), 0;
    int len((int)(a.length() * 2 + 2));
    ma.assign(len, '\0');
    pa.assign(len, 0);
    ma[0] = '~';
    for(register int i(1), j(0); i < len; ++i) ma[i] = (i & 1) == 0 ? a[j++] : '|';
    int R(-1), C(-1), mx(0);
    for(int i(0); i < len; ++i) {
        pa[i] = R > i ? min(R-i, pa[(C << 1)-i]) : 1;
        while(ma[i-pa[i]] == ma[i+pa[i]]) ++pa[i];
        if(i + pa[i] > R) {
            R = i+pa[i];
            C = i;
        }
        mx = (mx > pa[i]) ? mx : pa[i];
    }
    cout << mx - 1;
    return 0;
}
