//Luogu P7073 [CSP-J2020] 表达式
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
#include<stack>
using namespace std;

const int MAXN = 1e5+10;
const int MOD = 1e9+7;
char str[MAXN*10];
int xi[MAXN];
int n, q;

typedef struct node{
	char data[10];
	struct node *lchd;
	struct node *rchd;
}*T;
T tree;

inline bool isOpNum(const char &ch) {
	if(ch == ' ' || ch == '&' || ch == '|') return false;
	return true;
}

void searchPostfix(const T &t) {
    if(t != NULL) {
        searchPostfix(t->lchd);
        searchPostfix(t->rchd);
        for(int i = 0; t->data[i]; ++i) {
        	printf("%c ", t->data[i]);
		}
    }
}

int main() {
	gets(str);
	T stack[MAXN], p;
	int top = -1, num=0;
	for(int i = 0; str[i]; ++i) {
		bool flag = false;
		char x = str[i];
		if(x == ' ') continue;
		cout << x << endl;
		if(x == 'x') {
			sscanf(str+i+1, "%d", &num);
			cout << num << endl;
			flag = true;
		}
		p = (T)malloc(sizeof(node));
		memset(p->data, 0, sizeof p->data);
		p->data[0] = x;
		if(flag) p->data[1] = (char)num;
		p->lchd = NULL;
		p->rchd = NULL;
		if(isOpNum(x)) 
			stack[++top] = p;
		else {
			p->lchd = stack[top-1];
			p->rchd = stack[top];
			stack[--top] = p;
			tree = p;
		}
	}
	tree = stack[0];
	return 0;
}