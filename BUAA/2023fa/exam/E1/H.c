#include<stdio.h>

int main() {
    int n, i, a, b, flag;
    scanf("%d", &n);
    for(i = 0; i < n; ++i) {
        scanf("%d%d", &a, &b);
        flag = 0;
        switch (a) {
            case 0:
                if(b >= 6 && b <= 18) flag = 1;
                break;
            case 1: case 4:
                if(b >= 4 && b <= 12) flag = 1;
                break;
            case 2: case 5: case 8:
                if(b == 2 || b == 3 || b == 5 || b == 6) flag = 1;
                break;
            case 3: case 6: case 9: case 12:
                if(b == 0) flag = 1;
                break;
            default:
                break;
        }
        if(flag) printf("Yes\n");
        else printf("No\n");
    }
    return 0;
}