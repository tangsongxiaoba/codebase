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
    output wire [2:0] npcOp   ,
    output wire [3:0] aluOp   ,
    output wire       tUseRs  ,
    output wire [1:0] tUseRt  ,
    output wire [1:0] tNew
);

// support instr
wire j   ;
wire jr  ;
wire jal ;
wire beq ;
wire ori ;
wire lui ;
wire lw  ;
wire sw  ;
wire add ;
wire sub ;
wire x_or;
wire _and;
wire _or ;
wire slt ;
wire sltu;
wire addi;
wire andi;
wire bne ;
wire lb  ;
wire lh  ;
wire sb  ;
wire sh  ;

// R Type
assign add  = (opcode == `CTRL_R) & (funct == `CTRL_ADD);
assign sub  = (opcode == `CTRL_R) & (funct == `CTRL_SUB);
assign x_or = (opcode == `CTRL_R) & (funct == `CTRL_XOR);
assign jr   = (opcode == `CTRL_R) & (funct == `CTRL_JR);
assign _and = (opcode == `CTRL_R) & (funct == `CTRL_AND);
assign _or  = (opcode == `CTRL_R) & (funct == `CTRL_OR);
assign slt  = (opcode == `CTRL_R) & (funct == `CTRL_SLT);
assign sltu = (opcode == `CTRL_R) & (funct == `CTRL_SLTU);


//I Type
assign addi = (opcode == `CTRL_ADDI);
assign andi = (opcode == `CTRL_ANDI);
assign ori  = (opcode == `CTRL_ORI);
assign lui  = (opcode == `CTRL_LUI);

//Load/Store Type
assign lw = (opcode == `CTRL_LW);
assign sw = (opcode == `CTRL_SW);
assign lb = (opcode == `CTRL_LB);
assign lh = (opcode == `CTRL_LH);
assign sb = (opcode == `CTRL_SB);
assign sh = (opcode == `CTRL_SH);

//B Type
assign beq = (opcode == `CTRL_BEQ);
assign bne = (opcode == `CTRL_BNE);

//J Type
assign j   = (opcode == `CTRL_J);
assign jal = (opcode == `CTRL_JAL);

//signals
assign ext      = lw | sw | lb | lh | sb | sh | beq | bne | addi;
assign aluSrc   = ori | lui | lw | sw | lb | lh | sb | sh | addi | andi;
assign memWrite = ((sw) ? 3 :
    (sh) ? 2 :
    (sb) ? 1 :
    0);
assign regWrite = (opcode == `CTRL_R) | lw | lb | lh | ori | lui | jal | andi | addi;

assign loadOp = ((lh) ? 4 :
    (lb) ? 2 :
    0); // lw

assign regDst = ((opcode == `CTRL_R) ? `REGDST_R :
    (jal) ? `REGDST_LINK :
    `REGDST_DEFAULT);

assign regFrom = ((lw | lb | lh) ? `REGFROM_LOAD :
    // (jal) ? `REGFROM_LINK :
    `REGFROM_DEFAULT);

//ALU Op
assign aluOp = ((ori | _or) ? `ALU_OR :
    (add | lw | sw | lb | lh | sb | sh | addi) ? `ALU_ADD :
    (lui) ? `ALU_LUI :
    (sub | beq) ? `ALU_SUB :
    (x_or) ? `ALU_XOR :
    (jal) ? `ALU_LINK :
    (andi | _and) ? `ALU_AND :
    (slt) ? `ALU_SLT :
    (sltu) ? `ALU_SLTU :
    (bne) ? `ALU_BNE :
    `ALU_SLL);

//NPC Op
assign npcOp = ((beq | bne) ? `NPC_B :
    ((j | jal) ? `NPC_J :
        ((jr) ? `NPC_JR :
            `NPC_DEFAULT)));

// T_use
assign tUseRs = ((add | sub | x_or | _and | _or | slt | sltu) | (ori | lui | addi | andi) | (lw | sw | lb | lh | sb | sh)) ? 1'b1 :
    ((beq | jr | bne) ? 1'b0 :
        1'bz);
assign tUseRt = ((sw | sb | sh) ? 2 :
    ((add | sub | x_or | _and | _or | slt | sltu) ? 1 :
        ((beq | bne) ? 0 :
            2'bzz)));

// T_new
wire [1:0] tNewE;
wire [1:0] tNewM;

assign tNewE = ((lw | lb | lh) ? 2 :
    (((add | sub | x_or | _and | _or | slt | sltu) | (ori | lui | addi | andi)) ? 1 :
        ((jal) ? 0 :
            2'bzz)));

assign tNewM = ((lw | lb | lh) ? 1 :
    (((add | sub | x_or | _and | _or | slt | sltu) | (ori | lui | addi | andi) | (jal)) ? 0 :
        2'bzz));

assign tNew = (TYPE == `TYPE_E ? tNewE :
    (TYPE == `TYPE_M ? tNewM :
        0));

endmodule
