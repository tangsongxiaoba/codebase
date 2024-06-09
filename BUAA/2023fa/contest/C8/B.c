#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int main() {
    unsigned int a,b,c;
    while(scanf("%u%u%u", &a, &b, &c) != EOF) {
        printf("%u\n", (a^b)^c);
    }
    return 0;
}
