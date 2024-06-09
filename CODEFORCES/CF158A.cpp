// CF158A.cpp
// Created by tsxb on 2023/8/20.
//
#include <iostream>
using namespace std;

int main() {
    int n, k, cnt, tot=0;
    cin >> n >> k;
    while(k--) {
        cin >> cnt;
        if(cnt) ++tot;
        --n;
    }
    for(int x = cnt; n > 0;) {
        cin >> x;
        if(x && x == cnt) ++tot;
        --n;
    }
    while(n>0) {
        cin >> cnt;
        --n;
    }
    cout << tot;
    return 0;
}