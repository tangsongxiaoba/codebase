import sys
import getopt

# REG_NAMES = ["$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"]

REG_NAMES = [f"${i}" for i in range(32)]

OP_NAMES = ["", "", "j", "jal", "beq", "bne", "blez", "bgtz", "addi", "addiu", "slti", "sltiu", "andi", "ori", "xori", "lui"] + ["" for _ in range(16)] + ["lb", "lh", "", "lw", "lbu", "lhu", "", "", "sb", "sh", "", "sw"]

COP_RS_NAMES = ["mfc0", "", "", "", "mtc0"]

COP_FUNCT_NAMES = ["" for _ in range(24)] + ["eret"]

R_FUNCT_NAMES = ["sll", "", "srl", "sra", "sllv", "", "srlv", "srav", "jr", "jalr", "", "", "syscall", "break", "", "", "mfhi", "mthi", "mflo", "mtlo", "", "", "", "", "mult", "multu", "div", "divu", "", "", "", "", "add", "addu", "sub", "subu", "and", "or", "xor", "nor", "", "", "slt", "sltu"]

RT_NAMES = ["bltz", "bgez"]

START_ADDR = 0x0000_3000

ADDR_PREFIX = "ADDR_"

labels = {}

def sign_ext(imm16):
    sign_bit = 1 << (16 - 1)
    if imm16 & sign_bit:
        imm16 -= (1 << 16)
    return imm16

def jump(target, pc):
    global labels
    string = ADDR_PREFIX
    target = target & ((1 << 26) - 1)
    num = (pc & ~((1 << 28) - 1)) | (target << 2)
    string += hex(num)
    labels[num] = string
    return string

def branch(offset, pc):
    global labels
    string = ADDR_PREFIX
    offset = offset & ((1 << 16) - 1)
    offset = sign_ext(offset)
    offset = offset << 2
    num = pc + 4 + offset
    string += hex(num)
    labels[num] = string
    return string

def disAssemble(codes):
    global labels
    instrs = {}
    for i, line in enumerate(codes):
        code = int(line.strip(), 16)
        if code == 0:
            instrs[i] = "nop"
            continue
        instr = ""
        pc = START_ADDR + i * 4
        op = code >> 26
        rs = (code >> 21) & ((1 << 5) - 1)
        rt = (code >> 16) & ((1 << 5) - 1)
        rd = (code >> 11) & ((1 << 5) - 1)
        shamt = (code >>  6) & ((1 << 5) - 1)
        funct = code & ((1 <<  6) - 1)
        imm16 = code & ((1 << 16) - 1)
        target = code & ((1 << 26) - 1)
        match op:
            case 0:
                instr += R_FUNCT_NAMES[funct]
            case 1:
                instr += RT_NAMES[rt]
            case 0x10:
                if rs == 0x10:
                    instr += COP_FUNCT_NAMES[funct]
                else:
                    instr += COP_RS_NAMES[rs]
            case _:
                instr += OP_NAMES[op]
        if instr == "":
            print("Unknown code: " + line)
            sys.exit(-1)
        instr += " "
        match op:
            case 0:
                match funct:
                    case 0|2|3: # shift
                        instr += f"{REG_NAMES[rd]}, {REG_NAMES[rt]}, {shamt}"
                    case 4|6|7: # shift-v
                        instr += f"{REG_NAMES[rd]}, {REG_NAMES[rt]}, {REG_NAMES[rs]}"
                    case 8: # jr
                        instr += f"{REG_NAMES[rs]}"
                    case 9: # jalr
                        instr += f"{REG_NAMES[rd]}, {REG_NAMES[rs]}"
                    case 12|13: # syscall, break
                        instr += ""
                    case 16|18: # mf
                        instr += f"{REG_NAMES[rd]}"
                    case 17|19: # mt
                        instr += f"{REG_NAMES[rs]}"
                    case 24|25|26|27: # mul div
                        instr += f"{REG_NAMES[rs]}, {REG_NAMES[rt]}"
                    case 32|33|34|35|36|37|38|39|42|43: # regular
                        instr += f"{REG_NAMES[rd]}, {REG_NAMES[rs]}, {REG_NAMES[rt]}"
                    case _:
                        print("invalid funct: " + line)
                        exit(-1)
            case 1: # bltz, bgez
                instr += f"{REG_NAMES[rs]}, " + branch(imm16, pc)
            case 0x10: # cop
                if rs != 0x10:
                    instr += f"{REG_NAMES[rt]}, {REG_NAMES[rd]}"
            case _:
                match op:
                    case 2|3: # j, jal
                        instr += jump(target, pc)
                    case 4|5: # beq, bne
                        instr += f"{REG_NAMES[rs]}, {REG_NAMES[rt]}, " + branch(imm16, pc)
                    case 6|7: # blez, bgtz
                        instr += f"{REG_NAMES[rs]}, " + branch(imm16, pc)
                    case 8|9|10|11: # common i
                        instr += f"{REG_NAMES[rt]}, {REG_NAMES[rs]}, {sign_ext(imm16)}"
                    case 12|13|14:
                        instr += f"{REG_NAMES[rt]}, {REG_NAMES[rs]}, {imm16}"
                    case 15: # lui
                        instr += f"{REG_NAMES[rt]}, {imm16}"
                    case 32|33|35|36|37|40|41|43: # load-store
                        instr += f"{REG_NAMES[rt]}, {sign_ext(imm16)}({REG_NAMES[rs]})"
                    case _:
                        print("Unknown op: " + line)
                        exit(-1)
        instrs[i] = instr
    text = []
    for i, line in enumerate(codes):
        pc = START_ADDR + i * 4
        if pc in labels.keys():
            text.append(labels[pc] + ":")
        text.append(instrs[i])
    return text

def getArgs():
    try:
        opts, _ = getopt.getopt(sys.argv[1:], "i:o:")
    except getopt.GetoptError:
        print("Usage: disasm.py -i <inputFile> -o <outputFile>")
        sys.exit(-1)
    mac_path = None
    asm_path = None
    for name, value in opts:
        if name == "-i":
            mac_path = value
        if name == "-o":
            asm_path = value
    if mac_path == None or asm_path == None:
        print("Usage: disasm.py -i <inputFile> -o <outputFile>")
        sys.exit(-1)
    return mac_path, asm_path

def main():
    mac_path, asm_path = getArgs()
    with open(mac_path, 'r') as file:
        mac_code = file.readlines()
    asm_code = disAssemble(mac_code)
    with open(asm_path, 'w') as file:
        file.write("\n".join(asm_code))

if __name__ == "__main__":
    main()