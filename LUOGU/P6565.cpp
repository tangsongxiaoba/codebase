//Luogu P6565 [NOI Online #3 入门组] 最急救助
#include<cstdio>
#include<cstring>
#include<iostream>
using namespace std;

int maxn = -0x7fffffff;
int n, t[105];

int main() {
    string sos, name[105];
    scanf ("%d", &n);
    for(register int i = 1; i <= n; ++i) {
    	cin >> name[i] >> sos;
    	register int len = sos.length();
    	for(register int j = 0; j < len; ++j) {
    		if(sos[j] == 's' && sos[j + 1] == 'o' && sos[j + 2] == 's') ++t[i];
			maxn = maxn > t[i] ? maxn : t[i];
		}
    }
    for(register int i = 1; i <= n; ++i)
    	if(t[i] == maxn)
    		cout << name[i] << " ";
    puts("");
	printf("%d\n", maxn);
    return 0;
}