//Luogu P1059 明明的随机数
#include<cstdio>
#include<iostream>
using namespace std;

const int MAXN = 100000;
int num[MAXN], a[MAXN];

int Partition(int l, int r) {
	int x = num[r];
	int i = l;
	int j = l - 1;
	for(; i < r; ++i) {
		if( num[i] < x ) {
			++j;
			if(j != i) swap(num[j], num[i]);
		}
	}
	swap(num[j + 1], num[r]);
	return j + 1; 
}

void Quick_Sort(int l, int r) {
	if(l < r) {
		int i = Partition(l, r);
		Quick_Sort(l, i - 1);
		Quick_Sort(i + 1, r);
	}
}

int main() {
	int N, ans=0;
	cin >> N;
	for(int i = 0; i < N; ++i) cin >> num[i];
	Quick_Sort(0, N-1);
	for(int i = 0; i <= N-1; ++i) {
		if(i != 0 && num[i] == num[i-1]) continue;
		a[ans++] = num[i];
	}
	cout << ans << endl;
	for(int i = 0; i < ans; ++i) cout << a[i] <<" ";
} 