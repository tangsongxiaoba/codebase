//Luogu P1750 出栈队列
#include<cstdio>
using namespace std;

const int _MAX=2147483647;
int s[10010];
int a[10010];
int top=-1;
int n;

void push(int t){
	++top;
	s[top]=t;
	return;
}

void pop(){
	if(top!=-1) {
		printf("%d ",s[top]);
		--top;	
	}
	return;
}

int check(int i, int c){
	int _fmin=i;
	while(c>0 && i<n){
		if(a[_fmin] > a[i]) _fmin = i;
		++i;
		--c;
	}
	if(top <= -1 || a[_fmin] < s[top]) return _fmin;
	return -1;
}

int main(){
	int c,_fmin=0;
	scanf("%d %d",&n,&c);
	for(int i=0; i<n; ++i){
		int t;
		scanf("%d",&t);
		a[i]=t;
	}
	for(int i=0; i<n;){
//		if(top==-1){
//			push(a[i]);
//			++i;
//		}
		int nc= c-top-1;
		_fmin=check(i, nc);
		for(;i<=_fmin;++i) push(a[i]);
		pop();
	}
	while(top!=-1) pop();
	
	return 0;
}