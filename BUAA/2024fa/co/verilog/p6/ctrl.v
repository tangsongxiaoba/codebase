`include "macro.v"

module ctrl #(parameter integer TYPE = `TYPE_D) (
    input  wire [5:0] opcode  ,
    input  wire [5:0] funct   ,
    output wire       ext     , // sign extend imm16 if 1
    output wire       aluSrc  , // I-Type, load imm16 as srcB rather than GPR[rt]
    output wire [1:0] memWrite, // Store data from reg to mem
    output wire       regWrite, // for those "GPR[xx] <- xx" in RTL
    output wire [1:0] regDst  , // R-Type, save value to GPR[rd] rather than GPR[rt]
    output wire [1:0] regFrom , // Load data from mem to reg
    output wire [2:0] loadOp  ,
    output wire [3:0] mdOp    ,
    output wire [2:0] npcOp   ,
    output wire [3:0] aluOp   ,
    output wire       tUseRs  ,
    output wire [1:0] tUseRt  ,
    output wire [1:0] tNew
);

//signals
assign ext      = lw | sw | lb | lh | sb | sh | beq | bne | addi;
assign aluSrc   = ori | lui | lw | sw | lb | lh | sb | sh | addi | andi;
assign regWrite = (opcode == `CTRL_R) | lw | lb | lh | ori | lui | jal | andi | addi;

assign memWrite =
    (sw) ? 3 :
    (sh) ? 2 :
    (sb) ? 1 :
    0;

assign loadOp =
    (lh) ? 4 :
    (lb) ? 2 :
    0; // lw

assign regDst =
    (opcode == `CTRL_R) ? `REGDST_R :
    (jal) ? `REGDST_LINK :
    `REGDST_DEFAULT;

assign regFrom =
    (lw | lb | lh) ? `REGFROM_LOAD :
    (mfhi | mflo) ? `REGFROM_HILO :
    `REGFROM_DEFAULT;

assign mdOp =
    (mult) ? `MULT :
    (multu) ? `MULTU :
    (div) ? `DIV :
    (divu) ? `DIVU :
    (mthi) ? `MTHI :
    (mtlo) ? `MTLO :
    (mfhi) ? `MFHI :
    (mflo) ? `MFLO :
    `NOT_MD;

//ALU Op
assign aluOp =
    (ori | _or) ? `ALU_OR :
    (add | lw | sw | lb | lh | sb | sh | addi) ? `ALU_ADD :
    (lui) ? `ALU_LUI :
    (sub | beq | bne) ? `ALU_SUB :
    (x_or) ? `ALU_XOR :
    (jal) ? `ALU_LINK :
    (andi | _and) ? `ALU_AND :
    (slt) ? `ALU_SLT :
    (sltu) ? `ALU_SLTU :
    `ALU_SLL;

//NPC Op
assign npcOp =
    (beq) ? `NPC_B :
    (j | jal) ? `NPC_J :
    (jr) ? `NPC_JR :
    (bne) ? `NPC_BN :
    `NPC_DEFAULT;

// T_use
assign tUseRs =
    ((add | sub | x_or | _and | _or | slt | sltu) |
        (ori | lui | addi | andi) |
        (mult | multu | div | divu | mthi | mtlo) |
        (lw | sw | lb | lh | sb | sh)) ? 1'b1 :
    (beq | jr | bne) ? 1'b0 :
    1'bz;

assign tUseRt =
    (sw | sb | sh) ? 2 :
    (add | sub | x_or | _and | _or | slt | sltu | mult | multu | div | divu) ? 1 :
    (beq | bne) ? 0 :
    2'bzz;

// T_new
assign tNewE =
    (lw | lb | lh) ? 2 :
    ((add | sub | x_or | _and | _or | slt | sltu) |
        (ori | lui | addi | andi) |
        (mfhi | mflo)) ? 1 :
    (jal) ? 0 :
    2'bzz;

assign tNewM =
    (lw | lb | lh) ? 1 :
    ((add | sub | x_or | _and | _or | slt | sltu) |
        (ori | lui | addi | andi) |
        (jal) |
        (mfhi | mflo)) ? 0 :
    2'bzz;

assign tNew = (TYPE == `TYPE_E ? tNewE :
    TYPE == `TYPE_M ? tNewM :
    0);

wire [1:0] tNewE;
wire [1:0] tNewM;

//support instr
// R Type
wire add   = (opcode == `CTRL_R) & (funct == `CTRL_ADD)  ;
wire sub   = (opcode == `CTRL_R) & (funct == `CTRL_SUB)  ;
wire x_or  = (opcode == `CTRL_R) & (funct == `CTRL_XOR)  ;
wire jr    = (opcode == `CTRL_R) & (funct == `CTRL_JR)   ;
wire _and  = (opcode == `CTRL_R) & (funct == `CTRL_AND)  ;
wire _or   = (opcode == `CTRL_R) & (funct == `CTRL_OR)   ;
wire slt   = (opcode == `CTRL_R) & (funct == `CTRL_SLT)  ;
wire sltu  = (opcode == `CTRL_R) & (funct == `CTRL_SLTU) ;
wire mfhi  = (opcode == `CTRL_R) & (funct == `CTRL_MFHI) ;
wire mthi  = (opcode == `CTRL_R) & (funct == `CTRL_MTHI) ;
wire mflo  = (opcode == `CTRL_R) & (funct == `CTRL_MFLO) ;
wire mtlo  = (opcode == `CTRL_R) & (funct == `CTRL_MTLO) ;
wire mult  = (opcode == `CTRL_R) & (funct == `CTRL_MULT) ;
wire multu = (opcode == `CTRL_R) & (funct == `CTRL_MULTU);
wire div   = (opcode == `CTRL_R) & (funct == `CTRL_DIV)  ;
wire divu  = (opcode == `CTRL_R) & (funct == `CTRL_DIVU) ;
//I Type
wire addi = (opcode == `CTRL_ADDI);
wire andi = (opcode == `CTRL_ANDI);
wire ori  = (opcode == `CTRL_ORI) ;
wire lui  = (opcode == `CTRL_LUI) ;
//Load/Store Type
wire lw = (opcode == `CTRL_LW);
wire sw = (opcode == `CTRL_SW);
wire lb = (opcode == `CTRL_LB);
wire lh = (opcode == `CTRL_LH);
wire sb = (opcode == `CTRL_SB);
wire sh = (opcode == `CTRL_SH);
//B Type
wire beq = (opcode == `CTRL_BEQ);
wire bne = (opcode == `CTRL_BNE);
//J Type
wire j   = (opcode == `CTRL_J)  ;
wire jal = (opcode == `CTRL_JAL);

endmodule
