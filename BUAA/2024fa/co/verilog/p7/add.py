import os

cwd = os.getcwd()

content = []

for root, dirs, files in os.walk(cwd):
    for file in files:
        if file.endswith('.v'):
            file_path = os.path.join(root, file)
            content.append(f'verilog work "{file_path}"\n')

with open("mips.prj", "w") as file:
    file.writelines(content)