#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    int n, year, month, date, hour, minute;
    n = read();
    while(n--) {
        year = read(), month = read(), date = read(), hour = read(), minute = read();
        hour += minute / 60, minute %= 60;
        date += hour / 24, hour %= 24;
        while(month > 12) month -= 12, ++year;
        while(date > 31) {
            switch(month) {
            case 1: case 3: case 5: case 7: case 8: case 10: case 12:
                date -= 31, ++month;
                break;
            case 4: case 6: case 9: case 11:
                date -= 30, ++month;
                break;
            case 2:
                if((year % 400 == 0)||((year % 4 == 0) && (year % 100 != 0))) {
                    date -= 29, ++month;
                }
                else {
                    date -= 28, ++month;
                }
                break;
            default:
                break;
            }
            if(month > 12) month -= 12, ++year;
        }
        switch(month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            break;
        case 4: case 6: case 9: case 11:
            if(date > 30) date -= 30, ++month;
            break;
        case 2:
            if((year % 400 == 0)||((year % 4 == 0) && (year % 100 != 0))) {
                if(date > 29) date -= 29, ++month;
            }
            else {
                if(date > 28) date -= 28, ++month;
            }
            break;
        default:
            break;
        }
        if(year < 10000) printf("%04d.%02d.%02d %02d:%02d\n", year, month, date, hour, minute);
        else printf("%05d.%02d.%02d %02d:%02d\n", year, month, date, hour, minute);
    }
    return 0;
}
