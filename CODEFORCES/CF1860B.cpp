//CF1860B.cpp
#include <iostream>
#include <cmath>
using namespace std;

int gmin(int a, int b) {
    return a < b ? a : b;
}

int main() {
    int t, m, k, a1, ak;
    long long vk = 0;
    cin >> t;
    while(t--) {
        cin >> m >> k >> a1 >> ak;
        vk = 1LL * ak * k;
        if(vk <= m) {
            m -= vk;
            if(m <= a1) {
                puts("0");
                continue;
            }
            else {
                m -= a1; 
                if(abs(ceil(1.0*m/k)*k - m) <= a1) cout << gmin(m - int(m/k)*(k-1), int(ceil(1.0*m/k))) <<endl;
                else cout << m - int(m/k)*(k-1)<<endl;
                continue;
            }
        }
        else {
            if(m % k == 0) {
                puts("0");
                continue;
            }
            else {
                m -= int(m/k)*k;
                if(m <= a1) {
                    puts("0");
                    continue;
                }
                else {
                    m -= a1;
                    cout << m - int(m/k)*(k-1)<<endl;
                    continue;
                }
            }
        }
    }
    return 0;
}