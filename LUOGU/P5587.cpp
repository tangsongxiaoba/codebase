//Luogu P5587 打字练习
#include<string>
#include<algorithm>
#include<iostream>
using namespace std;

const int MAXN = 1e4+10;
string s[MAXN], t[MAXN], s1;
long long n, m, cnt;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    while(getline(cin, s1), s1 != "EOF") {
        ++n;
        for(char i:s1) {
            if(i == '<') {
                if(!s[n].empty()) s[n].pop_back();
            }
            else s[n].push_back(i);
        }
    }
    while(getline(cin, s1), s1 != "EOF") {
        if(++m > n) break;
        for(char i:s1) {
            if(i == '<') {
                if(!t[m].empty()) t[m].pop_back();
            }
            else t[m].push_back(i);
        }
        for(register int i = 0; i < min(t[m].size(), s[m].size()); ++i) cnt += (s[m][i] == t[m][i]);
    }
    cin >> m;
    cout <<(long long) (cnt * 60.0 / m + 0.5);
    return 0;
}