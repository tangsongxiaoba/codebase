#include<stdio.h>

int main() {
    int year, score;
    while(scanf("%d%d", &year, &score) != EOF) {
        if(year == 2023) {
            if(score >= 85) {
                printf("%d\nYou can choose whether to take the course or not.\n", score);
            }
            else {
                printf("You have to take the course.\n");
            }
        }
        else {
            if(score >= 60) {
                printf("%d\n", score);
            }
            else {
                printf("You have to take the course.\n");
            }
        }
    }
    return 0;
}
