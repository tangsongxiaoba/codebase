#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
    puts("");
}

typedef struct node {
    int head, len, number;
    int* list;
} group;

group* box;

int compare_group(const void* p1, const void* p2) {
    static group* x1, *x2;
    x1 = (group*) p1;
    x2 = (group*) p2;
    /*printf("g %d %d\n", x1->head, x2->head);*/
    if(x1->head > x2->head) return 1;
    else if(x1->head < x2->head) return -1;
    else return 0;
}

int lower_bound(const void* p1, const void* p2) {
    static group* x1, *x2;
    x1 = (group*) p1;
    x2 = (group*) p2;
    /*printf("%d %d\n", x1->head, x2->head);*/
    if((x2 == box || compare_group(x1, x2 - 1) > 0) && compare_group(x1, x2) > 0) return 1;
    else if(x2 != box && compare_group(x1, x2 - 1) <= 0) return -1;
    else return 0;
}

int compare_list(const void* p1, const void* p2) {
    static int* x1, *x2;
    x1 = (int*) p1;
    x2 = (int*) p2;
    /*printf("%d %d\n", *x1, *x2);*/
    if(*x1 > *x2) return -1;
    else if(*x1 < *x2) return 1;
    else return 0;
}

int main() {
    int n = read(), m = read(), T = read(), i, j, p;
    int* a = (int*)malloc((n + 1) * sizeof(int));
    memset(a, 0, sizeof(int)*(n+1));
    for(i = 1; i <= n; ++i) a[i] = read();
    i = 1;
    box = (group*)realloc(box, (m + 10) * sizeof(group));
    for(p = 0; p < m; ++p) {
        box[p].head = a[i];
        box[p].number = i;
        for(j = i; a[j] <= a[i] && j <= n; ++j);
        box[p].list = (int*)malloc((j - i + 10) * sizeof(int));
        for(box[p].len = 0; i < j && i <= n; ++i, ++(box[p].len)) box[p].list[box[p].len] = a[i];
    }
    free(a);
    /*qsort(box, m, sizeof(group), compare_group);*/
    /*for(i = 0; i < m; ++i) {
      printf("%d: ", i);
      for(j = 0; j < (box+i)->len; ++j) {
      printf("%d ", *(((box+i)->list)+j));
      }
      puts("");
      }*/
    group key;
    while(T--) {
        key.head = read();
        group* target = (group*)bsearch(&key, box, m, sizeof(group), lower_bound);
        if(target == NULL) {
            puts("0");
            continue;
        }
        /*puts("");
          write(target->head);*/
        int* res = (int*)bsearch(&key.head, (target->list), (target->len), sizeof(int), compare_list);
        if(res == NULL) puts("0");
        else {
            printf("%lld\n", target->number + (res - (target->list)));
        }
    }

    return 0;
}     
