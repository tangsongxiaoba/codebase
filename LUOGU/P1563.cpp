#include <iostream>
using namespace std;

struct Node {
    bool rot;
    string name;
}peo[100100];

int main() {
    int n, m, now = 0;
    bool cmd;
    int si;
    cin >> n >> m;
    for(int i = 0; i < n; ++i) {
        cin >> peo[i].rot >> peo[i].name;
    }
    for(int i = 0; i < m; ++i) {
        cin >> cmd >> si;
        if(cmd^peo[now].rot) {
            now += si;
            now %= n;
        }
        else {
            now -= si;
            while(now < 0) now += n;
            now %= n;
        }
    }
    cout << peo[now].name;

    return 0;
}