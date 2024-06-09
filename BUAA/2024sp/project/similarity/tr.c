#pragma GCC optimize("Ofast,no-stack-protector,unroll-loops,fast-math")
// #pragma GCC target("sse,sse2,sse3,ssse3,sse4.1,sse4.2,avx,avx2,popcnt,tune=native")  
#pragma GCC optimize(3)
#include <math.h> 
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define maxCount 200
#define max2(a,b) ((a)>(b)?(a):(b))
#define min2(a,b) ((a)<(b)?(a):(b))
#define abs2(x) (((x)>=0)?(x):-(x))
#define gc() (p1 == p2 && (p2 = (p1 = buf) + fread(buf, 1, 1 << 20, fp), p1 == p2) ? EOF : *p1++)
#define pc(c) (obuf[p3++] = c)
#define flush() (fwrite(obuf, 1, p3, stdout), p3 = 0)
#define MaxDP 3300
#define HASH 31

unsigned long long hash(char *s, int len) {
    unsigned long long h = 0;
    for(int i = 0; i < len; ++i) {
        int dig = s[i] - '_' + 1;
        h = h * HASH + dig;
    }
    return h;
}

struct node{
    char word[20];
    int len;
    unsigned long long hashvalue;
}a[200];

void keepwords() {
    FILE *fp = fopen("keepwords.txt", "r");
    char s[100];
    int u = 0;
    while(fscanf(fp, "%s", s) != EOF) {
        if(!isalpha(s[0])) continue;
        int len = strlen(s), j = 0;
        for(int i = 0; i < len; ++i) {
            if(!islower(s[i])) continue;
            a[u].word[j++] = s[i];
        }
        a[u].len = j;
        a[u++].word[j] = 0;
    }
    for(int i = 0; i < u; ++i) {
        a[i].hashvalue = hash(a[i].word, strlen(a[i].word));
    }
    for(int i=0; i<u-1; ++i) {
        for(int j=i+1; j<u ; ++j)
        {
            if(a[i].hashvalue > a[j].hashvalue)
            {
                struct node t = a[i];
                a[i] = a[j];
                a[j] = t;
            }
        }
    }
    for(int i = 0; i < u; ++i) {
        printf("%lluull,", a[i].hashvalue);
    }
    printf("\n%d", u);
    fclose(fp);
}

int main() {
    keepwords();
    return 0;
}