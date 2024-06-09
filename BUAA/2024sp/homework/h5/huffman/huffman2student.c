#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAXSIZE 32

struct tnode
{
	char c;
	int weight;
	struct tnode *left, *right;
};
int Ccount[128] = {0};
struct tnode *Root = NULL;
char HCode[128][MAXSIZE] = {{0}};
int Step = 0;
FILE *Src, *Obj;

void statCount();
void createHTree();
void makeHCode();
void atoHZIP();

void print1();
void print2(struct tnode *p);
void print3();
void print4();

int main()
{
	if ((Src = fopen("input.txt", "r")) == NULL)
	{
		fprintf(stderr, "%s open failed!\n", "input.txt");
		return 1;
	}
	if ((Obj = fopen("output.txt", "w")) == NULL)
	{
		fprintf(stderr, "%s open failed!\n", "output.txt");
		return 1;
	}
	scanf("%d", &Step);

	statCount();
	if (Step == 1)
		print1();
	createHTree();
	if (Step == 2)
		print2(Root);
	makeHCode();
	if (Step == 3)
		print3();
	if (Step >= 4)
		atoHZIP(), print4();

	fclose(Src);
	fclose(Obj);

	return 0;
}

char buf[1<<20];

void statCount()
{
	Src = fopen("input.txt", "r");
	buf[fread(buf, sizeof(char), 1<<20, Src)] = EOF;
	for(int i = 0; buf[i] != EOF; ++i)
		++Ccount[buf[i]];
	Ccount[0] = 1;
}

int cmp(const void* p, const void* q) {
	struct tnode *a = (struct tnode *)p;
	struct tnode *b = (struct tnode *)q;
	return (a->weight == b->weight) ? (a->c - b->c) : (a->weight - b->weight);
}

void createHTree()
{
	typedef struct node{
		struct tnode *dat;
		struct node *nxt;
	}*list, *nodeptr;
	
	list H = (list)malloc(sizeof(struct node));
	memset(H, 0, sizeof(struct node));
	H->dat = (struct tnode *)malloc(sizeof(struct tnode));
	memset(H->dat, 0, sizeof(struct tnode));
	int tot = 0;

	for(int i = 0; i < 128; ++i) {
		if(Ccount[i] > 0) {
			nodeptr p = (nodeptr)malloc(sizeof(struct node));
			p->dat = (struct tnode *)malloc(sizeof(struct tnode));
			p->dat->c = i; p->dat->weight = Ccount[i];
			p->dat->left = p->dat->right = NULL;
			p->nxt = NULL;
			nodeptr pp = H;
			while(pp->nxt != NULL) {
				nodeptr ppp = pp->nxt;
				if(ppp->dat->weight == p->dat->weight) {
					if(ppp->dat->c > p->dat->c) {
						break;
					}
				}
				else {
					if(ppp->dat->weight > p->dat->weight) {
						break;
					}
				}
				pp = ppp;
			}
			p->nxt = pp->nxt;
			pp->nxt = p;
			++tot;
		}
	}

	while(tot > 1) {
		nodeptr p = H->nxt, pp = H->nxt->nxt;
		nodeptr P = (nodeptr)malloc(sizeof(struct node));
		P->dat = (struct tnode *)malloc(sizeof(struct tnode));
		P->dat->c = -1, P->dat->weight = p->dat->weight + pp->dat->weight;
		P->dat->left = p->dat;
		P->dat->right = pp->dat;
		H->nxt = pp->nxt;
		free(p); free(pp);
		pp = H;
		while(pp->nxt != NULL) {
			nodeptr ppp = pp->nxt;
			if(ppp->dat->weight > P->dat->weight) {
				break;
			}
			pp = ppp;
		}
		P->nxt = pp->nxt;
		pp->nxt = P;
		--tot;
	}

	Root = H->nxt->dat;
}

void traversal(struct tnode *p, int res, int dep) {
	if(p != NULL)
	{
		if((p->left == NULL) && (p->right == NULL)) {
			for(int pos = 0, r = res, d = dep; d > 0; --d) {
				HCode[p->c][pos++] = '0' + (r & 1);
				r >>= 1;
			}
		}
		traversal(p->left, res & ~(1 << dep), dep+1);
		traversal(p->right, res | (1 << dep), dep+1);
	}
}

void makeHCode()
{
	traversal(Root, 0, 0);
}

char hs[1<<20];

void atoHZIP()
{
	Obj = fopen("output.txt", "w");
	int p = 0;
	for(int i = 0; buf[i] != EOF; ++i) {
		int len = strlen(HCode[buf[i]]);
		for(int j = 0; j < len; ++j) {
			hs[p++] = HCode[buf[i]][j];
		}
	}
	int len = strlen(HCode[0]);
	for(int i = 0; i < len; ++i) {
		hs[p++] = HCode[0][i];
	}
	int c = 0, cnt = 7;
	for(int i = 0; i < p; ++i) {
		if(hs[i] - '0' == 1) {
			c |= (1 << cnt);
		}
		--cnt;
		if(cnt == -1) {
			fputc(c, Obj);
			printf("%x", c);
			c = 0;
			cnt = 7;
		}
	}
	if(c) {
		fputc(c, Obj);
		printf("%x", c);
	}
}

void print1()
{
	int i;
	printf("NUL:1\n");
	for (i = 1; i < 128; i++)
		if (Ccount[i] > 0)
			printf("%c:%d\n", i, Ccount[i]);
}

void print2(struct tnode *p)
{
	if (p != NULL)
	{
		if ((p->left == NULL) && (p->right == NULL)) {
			switch (p->c)
			{
			case 0:
				printf("NUL ");
				break;
			case ' ':
				printf("SP ");
				break;
			case '\t':
				printf("TAB ");
				break;
			case '\n':
				printf("CR ");
				break;
			default:
				printf("%c ", p->c);
				break;
			}
		}
		print2(p->left);
		print2(p->right);
	}
}

void print3()
{
	int i;

	for (i = 0; i < 128; i++)
	{
		if (HCode[i][0] != 0)
		{
			switch (i)
			{
			case 0:
				printf("NUL:");
				break;
			case ' ':
				printf("SP:");
				break;
			case '\t':
				printf("TAB:");
				break;
			case '\n':
				printf("CR:");
				break;
			default:
				printf("%c:", i);
				break;
			}
			printf("%s\n", HCode[i]);
		}
	}
}

void print4()
{
	long int in_size, out_size;

	fseek(Src, 0, SEEK_END);
	fseek(Obj, 0, SEEK_END);
	in_size = ftell(Src);
	out_size = ftell(Obj);

	printf("\n原文件大小：%ldB\n", in_size);
	printf("压缩后文件大小：%ldB\n", out_size);
	printf("压缩率：%.2f%%\n", (float)(in_size - out_size) * 100 / in_size);
}
