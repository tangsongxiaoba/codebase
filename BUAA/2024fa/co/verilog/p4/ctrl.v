`include "macro.v"

module ctrl (
    input  wire [5:0] opcode  ,
    input  wire [5:0] funct   ,
    output wire       ext     , // sign extend imm16 if 1
    output wire       aluSrc  , // I-Type, load imm16 as srcB rather than GPR[rt]
    output wire       memWrite, // Store data from reg to mem
    output wire       regWrite, // for those "GPR[xx] <- xx" in RTL
    output wire [1:0] regDst  , // R-Type, save value to GPR[rd] rather than GPR[rt]
    output wire [1:0] regFrom , // Load data from mem to reg
    output wire [2:0] npcOp   ,
    output wire [3:0] aluOp
);

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

// R Type
assign add  = (opcode == `CTRL_R) & (funct == `CTRL_ADD);
assign sub  = (opcode == `CTRL_R) & (funct == `CTRL_SUB);
assign x_or = (opcode == `CTRL_R) & (funct == `CTRL_XOR);
assign jr   = (opcode == `CTRL_R) & (funct == `CTRL_JR);

//I Type
assign ori = (opcode == `CTRL_ORI);
assign lui = (opcode == `CTRL_LUI);

//Load/Store Type
assign lw = (opcode == `CTRL_LW);
assign sw = (opcode == `CTRL_SW);

//B Type
assign beq = (opcode == `CTRL_BEQ);

//J Type
assign j   = (opcode == `CTRL_J);
assign jal = (opcode == `CTRL_JAL);

//signals
assign ext      = lw | sw | beq;
assign aluSrc   = ori | lui | lw | sw;
assign memWrite = sw;
assign regWrite = (opcode == `CTRL_R) | lw | ori | lui | jal;

assign regDst = (opcode == `CTRL_R ? `REGDST_R :
    (jal) ? `REGDST_LINK :
    `REGDST_DEFAULT);

assign regFrom = ((lw) ? `REGFROM_LOAD :
    (jal) ? `REGFROM_LINK :
    `REGFROM_DEFAULT);

//ALU Op
assign aluOp = ((ori) ? `ALU_OR :
    (add | lw | sw) ? `ALU_ADD :
    (lui) ? `ALU_LUI :
    (sub | beq) ? `ALU_SUB :
    (x_or) ? `ALU_XOR :
    `ALU_SLL);

//NPC Op
assign npcOp = ((beq) ? `NPC_B :
    ((j | jal) ? `NPC_J :
        ((jr) ? `NPC_JR :
            `NPC_DEFAULT)));

endmodule
