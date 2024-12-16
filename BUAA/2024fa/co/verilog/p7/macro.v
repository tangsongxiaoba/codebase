`default_nettype none

// PC
`define PC_INIT 32'h0000_3000
`define PC_END 32'h0000_6ffc

// DM
`define DM_MAX 3072
`define DM_INIT 32'h0000_0000
`define DM_END 32'h0000_2fff

// EXC
`define EXC_INIT 32'h0000_4180

// TC
`define TC0_INIT 32'h0000_7f00
`define TC0_END 32'h0000_7f0b
`define TC1_INIT 32'h0000_7f10
`define TC1_END 32'h0000_7f1b

// IG
`define IG_INIT 32'h0000_7f20
`define IG_END 32'h0000_7f23

// IM
`define IM_MAX 4096
`define CODEPATH "code.txt"

// GRF
`define REG_MAX 32

// ALU
`define ALU_SLL 0
`define ALU_OR 1
`define ALU_ADD 2
`define ALU_LUI 3
`define ALU_SUB 4
`define ALU_LINK 5
`define ALU_XOR 6
`define ALU_AND 7
`define ALU_SLT 8
`define ALU_SLTU 9

// ALU EXC
`define ALUE_NONE 0
`define ALUE_OV 1
`define ALUE_ADEL 2
`define ALUE_ADES 3

// CTRL

// opcode
`define CTRL_R 6'b000000
`define CTRL_NOP 6'b000000
`define CTRL_J 6'b000010
`define CTRL_JAL 6'b000011
`define CTRL_BEQ 6'b000100
`define CTRL_BNE 6'b000101
`define CTRL_ADDI 6'b001000
`define CTRL_ANDI 6'b001100
`define CTRL_ORI 6'b001101
`define CTRL_LUI 6'b001111
`define CTRL_COP0 6'b010000
`define CTRL_LB 6'b100000
`define CTRL_LH 6'b100001
`define CTRL_LW 6'b100011
`define CTRL_SB 6'b101000
`define CTRL_SH 6'b101001
`define CTRL_SW 6'b101011

//funct
`define CTRL_JR 6'b001000
`define CTRL_SYSCALL 6'b001100
`define CTRL_MFHI 6'b010000
`define CTRL_MTHI 6'b010001
`define CTRL_MFLO 6'b010010
`define CTRL_MTLO 6'b010011
`define CTRL_MULT 6'b011000
`define CTRL_MULTU 6'b011001
`define CTRL_DIV 6'b011010
`define CTRL_DIVU 6'b011011
`define CTRL_ADD 6'b100000
`define CTRL_SUB 6'b100010
`define CTRL_AND 6'b100100
`define CTRL_OR 6'b100101
`define CTRL_XOR 6'b100110
`define CTRL_SLT 6'b101010
`define CTRL_SLTU 6'b101011

// COP0
`define CTRL_ERET 6'b011000
`define CTRL_MTC0 5'b00100
`define CTRL_MFC0 5'b00000

// NPC
`define NPC_B 1
`define NPC_J 2
`define NPC_JR 3
`define NPC_BN 4
`define NPC_DEFAULT 0

// REGDST
`define REGDST_R 1
`define REGDST_LINK 2
`define REGDST_DEFAULT 0

// REGFROM
`define REGFROM_LOAD 1
`define REGFROM_HILO 2
`define REGFROM_COP0 3
`define REGFROM_DEFAULT 0

// TYPE
`define TYPE_F 0
`define TYPE_D 1
`define TYPE_E 2
`define TYPE_M 3
`define TYPE_W 4

// MULT/DIV
`define NOT_MD 0
`define MULT 1
`define MTLO 2
`define MULTU 3
`define MTHI 4
`define DIV 5
`define MFHI 6
`define DIVU 7
`define MFLO 8

// ExcCode
`define EXC_NONE 0
`define EXC_INT 0
`define EXC_ADEL 4
`define EXC_ADES 5
`define EXC_SYSCALL 8
`define EXC_RI 10
`define EXC_OV 12

// CP0
`define EXL SR[1]
`define IM SR[15:10]
`define IE SR[0]
`define BD Cause[31]
`define IP Cause[15:10]
`define EXCCODE Cause[6:2]

// Store
`define SWORD 3
`define SHALF 2
`define SBYTE 1
`define SNONE 0

// Load
`define LWORD 3
`define LHALF 2
`define LBYTE 1
`define LNONE 0
