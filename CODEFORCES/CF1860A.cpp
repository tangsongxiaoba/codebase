//CF1860A.cpp
#include <iostream>
using namespace std;

bool f(string s) {
    int tmp = 0;
    while(tmp < s.length()-1) {
        if(s[tmp] == s[tmp+1]) return false;
        ++tmp;
    }
    return true;
}

int main() {
    int t;
    cin >> t;
    while(t--) {
        string s;
        cin >> s;
        if(s == "()") puts("NO");
        else if(s == ")(") puts("YES\n(())");
        else {
            puts("YES");
            if(f(s)) {
                for(int i = 0; i < s.length(); ++i) {
                    cout << '(';
                }
                for(int i = 0; i < s.length(); ++i) {
                    cout << ')';
                }
            }
            else {
                for(int i = 0; i < s.length(); ++i) {
                    cout << "()";
                }
            }
        }
        puts("");
    }
    return 0;
}