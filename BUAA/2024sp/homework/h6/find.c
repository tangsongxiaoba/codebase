#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define NHASH 3001
#define MULT 37

unsigned int hash(char *str){
    unsigned int h = 0;
    char *p;
    for(p = str; *p != '\0'; ++p)
        h = MULT * h + *p;
    return h % NHASH;
}

typedef struct Node {
    char *word;
    struct Node *nxt;
}node, *nodeptr;

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

char dic[3500][20];
int id[26][2];
nodeptr hash_table[NHASH];

int main() {
    FILE *fp = fopen("dictionary3000.txt", "r");
    int p = 0, op = 0, pp = 0;
    for(int i = 0; i < NHASH; ++i) {
        hash_table[i] = (nodeptr)malloc(sizeof(node));
        hash_table[i]->word = (char *)malloc(sizeof(char));
        *(hash_table[i]->word) = 0;
        hash_table[i]->nxt = NULL;
    }
    while(fscanf(fp, "%s", dic[p++]) != EOF) {
        if(dic[p-1][0] - 'a' > pp) { 
            id[pp][1] = p-1-id[pp][0];
            id[++pp][0] = p-1;
        }
        nodeptr P = hash_table[hash(dic[p-1])], pre = P;
        while(P->nxt != NULL) {
            if(strcmp(P->word, dic[p-1]) > 0) break;
            pre = P;
            P = P->nxt;
        }
        nodeptr ppp = (nodeptr)malloc(sizeof(node));
        ppp->word = (char *)malloc(sizeof(char) * strlen(dic[p-1]));
        strcpy(ppp->word, dic[p-1]);
        ppp->nxt = pre->nxt;
        pre->nxt = ppp;
    }
    id[pp][1] = (--p)-id[pp][0];
    char s[20];
    int low = 0, high = p-1, mid, flag = -1, cnt = 0;
    while(scanf("%s%d", s, &op) != EOF) {
        switch (op)
        {
        case 1: 
        {
            flag = -1, cnt = 0;
            for(int i = 0; i < p; ++i) {
                flag = strcmp(dic[i], s);
                ++cnt;
                if(flag >= 0) break;
            }
            flag == 0 ? write(1) : write(0);
            printf(" %d\n", cnt);
            break;
        }
        case 2:
        {
            low = 0, high = p-1, flag = -1, cnt = 0;
            while(low <= high) {
                mid = (low + high) / 2;
                flag = strcmp(dic[mid], s);
                ++cnt;
                if(flag == 0) break;
                if(flag < 0) {
                    low = mid + 1;
                }
                else high = mid - 1;
            }
            flag == 0 ? write(1) : write(0);
            printf(" %d\n", cnt);
            break;
        }
        case 3:
        {
            low = id[s[0]-'a'][0], high = id[s[0]-'a'][0] + id[s[0]-'a'][1] - 1, flag = 1, cnt = 0;
            if(s[0] == 'x') high = low-1;
            while(low <= high) {
                mid = (low + high) >> 1;
                flag = strcmp(dic[mid], s);
                ++cnt;
                if(flag == 0) break;
                if(flag < 0) {
                    low = mid + 1;
                }
                else high = mid - 1;
            }
            flag == 0 ? write(1) : write(0);
            printf(" %d\n", cnt);
            break;
        }
        case 4:
        {
            nodeptr P; 
            P = hash_table[hash(s)]->nxt;
            flag = -1, cnt = 0;
            while(P != NULL) {
                flag = strcmp(P->word, s);
                ++cnt;
                if(flag >= 0) break;
                P = P->nxt;
            }
            flag == 0 ? write(1) : write(0);
            printf(" %d\n", cnt);
            break;
        }
        }
    }
    return 0;
}
