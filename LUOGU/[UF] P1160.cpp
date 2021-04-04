//Luogu P1160 队列安排
#include<iostream>
using namespace std;

struct node{
    int x;
    node *prev, *next;
    node(int _x, node *_prev, node *_next) {
    	x = _x;
    	prev = _prev;
    	next = _next;
	}
};

node *head = new node(0, NULL, NULL);

node *insert(node *p, int x){
    node *q = new node(x, p, p->next);
    if (p->next) p->next->prev = q;
    p->next = q;
    return q;
}

void erase(node *p){
    p->prev->next = p->next;
    if(p->next) p->next->prev = p->prev;
    delete p;
}

node *findk(int k){
	node *p = head->next;
	for(int i = 0; i<k; ++i) p = p->next;
	return p;
}

void print(){
	for(node *i = head->next; i; i = i->next) cout << i->x << ' ';
}

node *q[100010];
int main(){
	q[1] = insert(head, 1);
    int N,M;
    cin >> N;
    int k,p,x;
    for(int i = 2; i <= N; ++i) {
    	cin >> k >> p;
    	if(p == 0) q[i] = insert(q[k] -> prev, i);
    	else q[i] = insert(q[k], i);
	}
	cin >> M;
	for(int i = 0; i < M; ++i) {
		cin >> x;
		if(q[x] != NULL ) erase(q[x]), q[x] = NULL;
	}
	print();
    return 0;
}