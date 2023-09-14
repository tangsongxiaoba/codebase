#include<iostream>
using namespace std;

int main() {
    int t;
    string a;
    cin >> t;
    while(t--) {
        cin >> a;
        if(a.find("1") > a.find("3")) {
            puts("31");
        }
        else {
            puts("13");
        }
    }
    return 0;
}