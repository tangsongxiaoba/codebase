// CF50A.cpp
// Created by tsxb on 2023/8/20.
//
#include <iostream>
using namespace std;

int tot;

int f(int m, int n) { // 好！
    if(m * n < 2) return 0;
    if(m < n) m ^= n, n ^= m, m ^= n;
    if(m == 2 * n) return n * n;
    else if(m > 2 * n) return n * n + f(m-2*n, n);
    else {
        if (n % 2) {
            return (n-1)*(n-1)/4 + f(m - (n-1) / 2, n - 1) + f(m, 1);
        }
        else {
            return n*n/4 + f(m - n/2, n);
        }
    }
}

int main() {
    int m, n;
    cin >> m >> n;
    tot += f(m, n);
    cout << tot; //cout << int(n * m / 2);
    return 0;
}