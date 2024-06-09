#include<bits/stdc++.h>
using namespace std;

string name, form_in, form_out;
string file_read_in, file_read_out;
string file_list[100010][2];
int number;
int List[200010];

inline int getNum(const string& s) {
    int num = 0;
    for(register int i = 0; i < s.length(); ++i) {
        if(!isdigit(s[i]) && isdigit(s[i-1])) break;
        if(!isdigit(s[i])) continue;
        num = num * 10 + (s[i] - '0');
    }
    return num;
}

int main() {
    register int i = 0, cnt = 0;
    cin >> name;
    number = getNum(name);
    if(isdigit(name[0]) && name.length() == 1) {
        number = name[0] - '0';
        int maxNum = -1;
        while(cin >> file_list[++cnt][0] >> file_list[cnt][1]) {
            int num = getNum(file_list[cnt][0]);
            List[num] = cnt;
            maxNum = max(maxNum, num);
        }
        string file = file_list[1][0];
        while(isdigit(file[file.length() - 1])) file = file.substr(0, file.length() - 1);
        for(i = file.length() - 1; i >= 0 && file[i] != '.'; --i);
        form_in = name.substr(i+1);
        file = file_list[1][1];
        while(isdigit(file[file.length() - 1])) file = file.substr(0, file.length() - 1);
        for(i = file.length() - 1; i >= 0 && file[i] != '.'; --i);
        form_out = name.substr(i+1);
        for(i = 0; i <= maxNum; ++i) {
            if(!List[i]) continue;
            file = file_list[List[i]][0];
            for(i = 0; i < name.length() && name[i] != '.' && !isdigit(name[i]); ++i);
            name = file.substr(0, i);
            cout << name << "." << form_in << number << " " << name << "." << form_out << number << endl;
            ++number;
        }
    }
    else {
        cin >> form_out;
        while(cin >> file_read_in >> file_read_out) ++cnt;
        if(isdigit(name[name.length() - 1])) {
            while(isdigit(name[name.length() - 1])) name = name.substr(0, name.length() - 1);
            for(i = name.length() - 1; i >= 0 && name[i] != '.'; --i);
            form_in = name.substr(i+1);
            for(i = 0; i < name.length() && name[i] != '.'; ++i);
            name = name.substr(0, i);
            for(i = 0; i < cnt; ++i) {
                cout << name << '.' << form_in << i + number << " " << name << "." << form_out << i + number << endl;
            }
        }
        else {
            for(i = name.length() - 1; i >= 0 && name[i] != '.'; --i);
            form_in = name.substr(i+1);
            for(i = 0; i < name.length() && !isdigit(name[i]); ++i);
            name = name.substr(0, i);
            for(i = 0; i < cnt; ++i) { 
                cout << name << i + number << "." << form_in << " " << name << i + number << "." << form_out << endl;
            }
        }
    }
    return 0;
}
