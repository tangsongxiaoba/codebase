#include<stdio.h>

int year, month, date, hour, minute, second;
char week[5];

void addDate() {
    ++date;
        switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            if(date > 31) {
                date = 1, ++month;
                if(month > 12) month = 1, ++year;
            }
            break;
        case 2:
            if((year % 4 == 0 && year % 100) || year % 400 == 0) {
                if(date > 29) date = 1, ++month;
            }
            else {
                if(date > 28) date = 1, ++month;
            }
            break;
        case 4: case 6: case 9: case 11:
            if(date > 30) date = 1, ++month;
            break;
        default:
            break;
        }
}

int main() {
    scanf("%d/%d/%d %d:%d:%d %s", &year, &month, &date, &hour, &minute, &second, week);
    if(week[0] != 'S' && (hour >= 9 && hour < 15 || (hour == 15 && minute == 0 && second == 0))) {
        printf("%04d/%02d/%02d", year, month, date);
        return 0;
    }
    if((week[0] == 'F' && (hour > 15 || (hour == 15 && (minute > 0 || second > 0)))) || week[0] == 'S') {
        if(week[0] == 'F') addDate(), addDate(), addDate();
        else if(week[1] == 'a') addDate(), addDate();
        else addDate();
        printf("%04d/%02d/%02d", year, month, date);
    }
    else if((hour > 15 || (hour == 15 && (minute > 0 || second > 0)))) {
        addDate();
        printf("%04d/%02d/%02d", year, month, date);
    }
    else {
        printf("%04d/%02d/%02d", year, month, date);
    }
    return 0;
}