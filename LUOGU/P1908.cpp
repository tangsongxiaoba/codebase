//Luogu P1908 逆序对
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN=500010;
int num[MAXN];
long long ans;
int L[MAXN/2], R[MAXN/2]; 

void Merge(int l, int mid, int r) {
	int  n1 = mid - l + 1, n2 = r - mid;
	for(int i = 0; i < n1; ++i) L[i] = num[l + i];
	for(int i = 0; i < n2; ++i) R[i] = num[mid + i + 1];
	int m = 0;
	for(int i = 0; i < n2; ++i) {
		for(; m < n1 && L[m] <= R[i]; ++m);
		ans += n1 - m;
	}
	int i = 0, j = 0, k = l;
	while(i < n1 && j < n2)
		if( L[i] < R[j] ) num[k++] = L[i++];
		else num[k++] = R[j++];
	while(i < n1) num[k++] = L[i++];
	while(j < n2) num[k++] = R[j++];
}

void Merge_Sort(int l, int r) {
	if(l < r) {
		int mid = l + r >> 1;
		Merge_Sort(l, mid);
		Merge_Sort(mid+1, r);
		Merge(l, mid, r);
	}
}

int main() {
	int n;
	scanf("%d", &n);
	for(int i=0; i<n; ++i) scanf("%d", &num[i]);
	Merge_Sort(0, n-1);
	printf("%lld", ans);
	return 0;
} 