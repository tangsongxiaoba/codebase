#include<iostream>
#include<cmath>
using namespace std;

const int INF = 0x7fffffff;

int main() {
    int n, ans = INF, t;
    cin >> n;
    while(n--) {
        cin >> t;
        if(abs(t) <= ans) ans = abs(t);
    }
    cout << t;
    return 0;
}