//Luogu P1095 [NOIP2007 普及组] 守望者的逃离
#include<iostream>
#include<cstdio>
using namespace std;

int m, s, t;
int s1, s2;

int main () {
	cin >> m >> s >> t;
	for(int i = 1; i <= t; ++i) {
		s1 = s1 + 17;
		if(m >= 10) {
			m = m - 10;
			s2 = s2 + 60;	
		}
		else m = m + 4;
		if(s2 > s1) s1 = s2;
		if(s1 >= s) {
			cout << "Yes" << endl;
			cout << i;
			return 0;
		}
	}
	cout << "No" << endl;
	cout << s1;
	return 0;
}  