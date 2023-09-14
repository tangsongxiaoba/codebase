#include <cmath>
#include <cstdio>
#include <iostream>
using namespace std;

string s1, s2;

int main() {
    //freopen("a.out", "w", stdout);
    char ch;
    int a11 = 0, b11 = 0, a21 = 0, b21 = 0;
    while(ch != 'E') {
        ch = getchar();
        if(ch == '\n' || ch == '\r') continue;
        if(ch == 'W') ++a11, ++a21;
        else ++b11, ++b21;
        if(a11 + b11 <= 20 && a11 != 10) {
            if(a11 == 11 || b11 == 11) {
                s1 += to_string(a11) + ":" + to_string(b11) + "\n";
                a11 = b11 = 0;
            }
        }
        else if(a11 + b11 > 20 && abs(a11 - b11) >= 2) {
            s1 += to_string(a11) + ":" + to_string(b11) + "\n";
            a11 = b11 = 0;
        }
        if(a21 + b21 <= 40 && a21 != 20) {
            if(a21 == 21 || b21 == 21) {
                s2 += to_string(a21) + ":" + to_string(b21) + "\n";
                a21 = b21 = 0;
            }
        }
        else if(a21 + b21 > 40 && abs(a21 - b21) >= 2) {
            s2 += to_string(a21) + ":" + to_string(b21) + "\n";
            a21 = b21 = 0;
        }
    }
    if(!(a11 == 0 && b11 == 0)) s1 += to_string(a11) + ":" + to_string(b11-1) + "\n\n";
    if(!(a21 == 0 && b21 == 0)) s2 += to_string(a21) + ":" + to_string(b21-1);
    cout << s1 << s2;
    return 0;
}