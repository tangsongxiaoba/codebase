//UVA11384 Help is needed for Dexter
#include<cstdio>

int f(const int &n) {
	return n == 1 ? 1 : f(n/2) + 1;
}

int main() {
	int n;
	while(scanf("%d", &n) == 1) 
		printf("%d\n", f(n));
	return 0;
}