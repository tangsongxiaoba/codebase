// CF231A.cpp
// Created by tsxb on 2023/8/20.
//
#include <iostream>

using namespace std;

bool a[3];

int main () {
    int num = 0, cnt = 0;
    cin >> num;

    while(num--) {
        cin >> a[0] >> a[1] >> a[2];
        if(a[0] + a[1] + a[2] >= 2) ++cnt;
    }

    cout << cnt;

    return 0;
}