import CVBB_LOGIN
import sys, getopt

def getArgs():
    try:
        opts, _ = getopt.getopt(sys.argv[1:], "i:p:")
    except getopt.GetoptError:
        print("Usage: login -i <id> -p <pwd>")
        sys.exit(-1)
    id = None
    pwd = None
    for name, value in opts:
        if name == "-i":
            id = value
        if name == "-p":
            pwd = value
    if id == None or pwd == None:
        print("Usage: login -i <id> -p <pwd>")
        sys.exit(-1)
    return id, pwd

if __name__ == "__main__":
    id, pwd = getArgs()
    login = CVBB_LOGIN.CVBB_LOGIN(id, pwd)
    info = login.run()
    if info == -1 :
        print("login failed.")
    elif info == 0 :
        flag = False
        for i in range(5):
            info = login.run()
            if info != 0 and info != -1:
                flag = True
                break
        if flag :
            print(f"login successful! received {info}")
        else :
            print("login faled.")
    else :
        print(f"login successful! received {info}")
