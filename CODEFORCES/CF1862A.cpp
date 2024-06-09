//CF1862A.cpp
#include <iostream>
using namespace std;

char carpet[30][30];
char name[4] = {'v','i','k','a'};

int main () {
    int t;
    cin >> t;
    while(t--) {
        int n, m;
        cin >> n >> m;
        for(int i = 0; i < n; ++i) {
            for(int j = 0; j < m; ++j) {
                cin >> carpet[j][i];
            }
        }
        int flag = 0;
        for(int j = 0; j < m; ++j) {
            for(int i = 0; i < n; ++i) {
                if(carpet[j][i] == name[flag]) {
                    ++flag;
                    break;
                }
            }
            if(flag == 4) break;
        }
        if(flag == 4) puts("YES");
        else puts("NO");
    }
    return 0;
}