#include<stdio.h>

int main() {
    int n, x, a, b, u, v, i, a1=0, b1=0, flag;
    scanf("%d%d%d%d", &n, &x, &a, &b);
    for(i = 0; i < n; ++i) {
        scanf("%d%d", &u, &v);
        flag = 0;
        switch (u) {
            case 1: /*eat*/
                if(v) { /*banana*/
                    if(b1) --b1, flag = 1;
                }
                else { /*apple*/
                    if(a1) --a1, flag = 1;
                }
                break;
            case 0: /*buy*/
                if(v) {
                    if(x >= 2 && b > 0) {
                        x -= 2;
                        ++b1, --b;
                        flag = 1;
                    }
                }
                else {
                    if(x >= 3 && a > 0) {
                        x -= 3;
                        ++a1, --a;
                        flag = 1;
                    }
                }
                break;
            default:
                break;
        }
        if(flag) printf("Ok!\n");
        else printf("Failed!\n");
    }
    printf("%d %d %d", a, b, x);
    return 0;
}