#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

char s1[1000];
char s2[1000];
char s3[1000];

void rep_part(char s1[], char s2[], int i, int j) {
    static char s[10005];
    strcpy(s, s1 + j + 1);
    s1[i] = '\0';
    strcat(s1, s2);
    strcat(s1, s);
}

void replace(char src[], char s1[], char s2[]) {
    int n = strlen(src), m = strlen(s1), i, j;
    for(i = 0; i < n-m+1; ++i) {
        for(j = 0; j < m; ++j) {
            if(tolower(src[i+j]) != tolower(s1[j])) 
                break;
        }
    if (j == m) {
        rep_part(src, s2, i, i+j-1);
    }
  }
}

int main() {
    gets(s1); gets(s2);
    freopen("filein.txt", "r", stdin);
    freopen("fileout.txt", "w", stdout);
    while(gets(s3) != NULL) {
        replace(s3, s1, s2);
        puts(s3);
    }
    return 0;
}
