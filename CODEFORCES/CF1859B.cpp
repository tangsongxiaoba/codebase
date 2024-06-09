// CF1859B.cpp
// Created by tsxb on 2023/8/22.
//
#include <iostream>
#include <algorithm>

using namespace std;

const int MAXN = 25100;
const int INF = 0x7fffffff;

int fst, sec[MAXN], vmin;

int main() {
    int t, n, m;
    cin >> t;
    while(t--) {
        cin >> n;
        vmin = INF;
        for(int i = 0, tmp; i < n; ++i) {
            fst = sec[i] = INF;
            cin >> m;
            while(m--) {
                cin >> tmp;
                if(fst > tmp) {
                    sec[i] = fst;
                    fst = tmp;
                }
                else if(sec[i] > tmp) {
                    sec[i] = tmp;
                }
            }
            if(vmin > fst) vmin = fst;
        }
        sort(sec, sec+n);
        long long res = vmin;
        for(int i = 1; i < n; ++i) {
            res += sec[i];
        }
        cout << res << endl;
    }
    return 0;
}
