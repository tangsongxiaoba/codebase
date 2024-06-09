// CF4A.cpp
// Created by tsxb on 2023/8/20.
//
#include <iostream>

using namespace std;

int main() {
    string s;
    int num;

    cin >> num;

    for(int i = 0; i < num; ++i) {
        cin >> s;
        if(s.length() > 10) {
            cout << s[0] << s.length() - 2 << s[s.length()-1];
        }
        else cout << s;
        puts("");
    }

    return 0;
}