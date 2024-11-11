`default_nettype none

// PC
`define PC_INIT 32'h0000_3000

// DM
`define DM_MAX 3072

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

// CTRL

// opcode
`define CTRL_R 6'b000000
`define CTRL_J 6'b000010
`define CTRL_JAL 6'b000011
`define CTRL_BEQ 6'b000100
`define CTRL_ORI 6'b001101
`define CTRL_LUI 6'b001111
`define CTRL_LW 6'b100011
`define CTRL_SW 6'b101011

//funct
`define CTRL_ADD 6'b100000
`define CTRL_SUB 6'b100010
`define CTRL_XOR 6'b100110
`define CTRL_JR 6'b001000

// NPC
`define NPC_B 1
`define NPC_J 2
`define NPC_JR 3
`define NPC_DEFAULT 0

// REGDST
`define REGDST_R 1
`define REGDST_LINK 2
`define REGDST_DEFAULT 0

// REGFROM
`define REGFROM_LOAD 1
`define REGFROM_LINK 2
`define REGFROM_DEFAULT 0

// TYPE
`define TYPE_F 0
`define TYPE_D 1
`define TYPE_E 2
`define TYPE_M 3
`define TYPE_W 4
