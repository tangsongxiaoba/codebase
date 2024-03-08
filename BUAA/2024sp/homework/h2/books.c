#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double


typedef struct node {
    char name[60];
    char author[30];
    char press[40];
    char date[20];
}BookInfo;

struct Node {
    BookInfo book;
    struct Node *next;
};

int IsLast(struct Node *P) {
    return P->next == NULL;
}

struct Node *MakeEmpty(struct Node *L) {
    L = malloc(sizeof(struct Node));
    L->next = NULL;
    return L;
}

struct Node *FindPrev(struct Node *P, struct Node *L) {
    struct Node *tmp;
    tmp = L;
    while(tmp->next != NULL && tmp->next != P) tmp = tmp->next;
    return tmp;
}

void Delete(struct Node *P, struct Node *L) {
    struct Node *Tmp;
    P = FindPrev(P, L);
    if(!IsLast(P)) {
        Tmp = P->next;
        P->next = Tmp->next;
        free(Tmp);
    }
}

struct Node *FindKey(char key[], struct Node* P) {
    while(P->next != NULL && strstr(P->book.name, key) == NULL) P = P->next;
    return P;
}

void Insert(BookInfo X, struct Node *L) {
    struct Node *Tmp, *P;
    P = L;
    while(P->next != NULL && strcmp(X.name, P->next->book.name) > 0) P = P->next;
    Tmp = malloc(sizeof(struct Node));
    Tmp->book = X;
    Tmp->next = P->next;
    P->next = Tmp;
}

void Print(BookInfo X) {
    printf("%-50s%-20s%-30s%-10s\n", X.name, X.author, X.press, X.date);
}

void PrintList(struct Node *L) {
    struct Node *P = L;
    if(L->next != NULL) {
        do {
            P = P->next;
            Print(P->book);
        } while(!IsLast(P));
    }
}

int main() {
    FILE *in;
    in = fopen("books.txt", "r");
    struct Node *lib = MakeEmpty(NULL), *p;
    BookInfo book;
    while(fscanf(in, "%s%s%s%s", book.name, book.author, book.press, book.date) != EOF) {
        Insert(book, lib);
    }
    fclose(in);
    int op;
    char keyWord[100];
    while(1) {
        scanf("%d", &op);
        if(op == 0) break;
        switch (op) {
            case 1:
                scanf("%s%s%s%s", book.name, book.author, book.press, book.date);
                Insert(book, lib);
                break;
            case 2:
                scanf("%s", keyWord);
                p = lib;
                while(p->next != NULL) {
                    p = p->next;
                    p = FindKey(keyWord, p);
                    if(strstr(p->book.name, keyWord) != NULL) Print(p->book);
                }
                break;
            case 3:
                scanf("%s", keyWord);
                p = lib;
                while(p->next != NULL) {
                    p = p->next;
                    p = FindKey(keyWord, p);
                    if(strstr(p->book.name, keyWord) != NULL) Delete(p, lib);
                }
                break;
            default:
                break;
        }
    }    
    freopen("ordered.txt", "w", stdout);
    PrintList(lib);
    return 0;
}
