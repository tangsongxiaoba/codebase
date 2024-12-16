with open("mips_tb.out", "r") as file:
    content = file.readlines()
    new_con = []
    for line in content:
        if "@" in line:
            new_con.append('@' + line.split(sep='@')[1])
    file.close()
with open("mips_tb.out", "w") as file2:
    file2.writelines(new_con)