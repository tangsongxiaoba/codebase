#include<stdio.h>

int main() {
    int n, i, td, failure = 0;
    scanf("%d", &n);
    while(n--) {
        for(i = 1; i <= 6; ++i) {
            scanf("%d", &td);
            if((failure && td > 48)|| td < 48) failure += 48 - td;
            if(failure < 0) failure = 0;
        }
        if(failure) printf("Failure %d\n", failure);
        else puts("Success");
        failure = 0;
    }
    return 0;
}