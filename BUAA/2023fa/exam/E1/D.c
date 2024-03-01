#include<stdio.h>

int main() {
    int a1, b1, a2, b2, a3, b3, op, x = 0, y = 0;
    scanf("%d%d%d%d%d%d%d", &a1, &b1, &a2, &b2, &a3, &b3, &op);
    switch (op) {
        case 1:
            printf("%d", a1*(b1+b2+b3)+a2*(b2+b3)+a3*b3);
            break;
        case 2:
            printf("%d", a2*(b1+b2+b3)+a3*(b1+b3)+a1*b1);
            break;
        case 3:
            printf("%d", a3*(b1+b2+b3)+a2*(b1+b2)+a1*b1);
            break;
        default:
            break;
    }
    return 0;
}