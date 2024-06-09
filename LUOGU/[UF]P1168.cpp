//Luogu P1168 中位数
#include<iostream>
#include<queue>
#include<cstdio>
#include<algorithm>

using namespace std;

priority_queue<int> Q1;
priority_queue<int, vector<int>, greater<int> > Q2;

int Abs(int i){
	return i > 0 ? i : -i;
}

int main() {
	int N,t, Size1, Size2;
	cin >> N >> t;
	cout << t << endl;
	Q1.push(t);
	for(int i = 1; i < N ; ++i) {
		cin >> t;
		if(t > Q1.top()) Q2.push(t);
		else Q1.push(t);
		Size1 = Q1.size(); Size2 = Q2.size();
		while(Abs( Size1 - Size2 ) > 1){
			if(Size1 > Size2) {
				Q2.push(Q1.top()); 
				Q1.pop();
				--Size1;
				++Size2;
			}
			else {
				Q1.push(Q2.top());
				Q2.pop();
				++Size1;
				--Size2;
			}
		}
		if(!(i%2)) cout <<( (Size1 > Size2) ? Q1.top() : Q2.top() )<< endl;
	}
	
	return 0;
}