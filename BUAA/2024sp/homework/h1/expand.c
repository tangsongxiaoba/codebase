#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int main() {
    char pre = '\0', now = '\0', nxt = '\0', ch;
    while((nxt = getchar())) {
        if(nxt == EOF) {
            putchar(now);
            break;
        }
        if(now == '-' && ((islower(pre) && islower(nxt)) || (isupper(pre) && isupper(nxt)) || (isdigit(pre) && isdigit(nxt))) && (nxt > pre)) {
            for(ch = pre+1; ch < nxt; ++ch) {
                putchar(ch);
            }
        }
        else if(isalpha(now) || isdigit(now) || now == '-') putchar(now);
        pre = now;
        now = nxt;
    }
    return 0;
}
