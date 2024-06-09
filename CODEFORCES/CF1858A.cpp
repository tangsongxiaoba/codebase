//CF1858A.cpp
#include <iostream>
using namespace std;

int main() {
    int t;
    cin >> t;
    while(t--) {
        int a, b, c;
        cin >> a >> b >> c;
        if (a > b) puts("First");
        else if(a < b) puts("Second");
        else if(c % 2) puts("First");
        else puts("Second");
    }
    return 0;
}