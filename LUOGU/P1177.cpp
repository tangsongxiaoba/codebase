//Luogu P1177 ¡¾Ä£°å¡¿¿ìËÙÅÅÐò
#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;

const int MAXN = 10000000;
int a[MAXN];

void QuickSort(int l, int r) {
	int low = l, high = r;
	int temp, check = a[(l+r)/2];
	do{
		while(a[low] < check) ++low;
		while(a[high] > check) --high;
		if(low <= high) {
			swap(a[low],a[high]);
			++low, --high;
		}
	}while(low<=high);
	if(l < high) QuickSort(l, high);
	if(low < r) QuickSort(low, r);
}

inline int read() {
	int res=0,f=1; char k;
	while(!isdigit(k=getchar())) if(k=='-') f=-1;
	while(isdigit(k)) res=res*10+k-'0',k=getchar();
	return res*f;
}

int main() {
	freopen("in", "r", stdin);
	freopen("1.txt", "w", stdout);
	int n = read();
	for(int i = 1; i <= n; ++i)
		a[i] = read();	
	QuickSort(1, n);
	for(int i = 1; i <= n; ++i) {
        if(i == n) printf("%d\n", a[i]);
        else printf("%d ", a[i]);
    }
	return 0;
} 
