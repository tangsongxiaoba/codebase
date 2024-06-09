//Luogu P1886 滑动窗口 /【模板】单调队列
#include <iostream>
#include <cstdio>
using namespace std;

const int MAXN = 1e6+19;
int a[MAXN], n, k;
int q1[MAXN], q2[MAXN];
int front, rear;

int main() {
	cin >> n >> k;
	for(int i = 1; i <= n; ++i) scanf("%d", &a[i]);	
	front = 1, rear = 0;
	for(int i = 1; i <= n; ++i) {
		while(front <= rear && q1[front] + k <= i) ++front;
		while(front <= rear && a[i] < a[q1[rear]]) --rear;
		q1[++rear] = i;
		if(i >= k) printf("%d ", a[q1[front]]);
	}
	putchar('\n');
	front = 1, rear = 0;
	for(int i = 1; i <= n; ++i) {
		while(front <= rear && q2[front] + k <= i) ++front;
		while(front <= rear && a[i] > a[q2[rear]]) --rear;
		q2[++rear] = i;
		if(i >= k) printf("%d ", a[q2[front]]);
	}
	return 0;
}