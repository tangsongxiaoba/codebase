`include "macro.v"

module mips (
    input wire clk  ,
    input wire reset
);

always @(posedge clk) begin
    if (reset != 1'b1) begin
        if (regWrite == 1'b1) begin
            $display("@%h: $%d <= %h", pc, a3, grfWD);
        end
        if (memWrite == 1'b1) begin
            $display("@%h: *%h <= %h", pc, aluRes, dat2);
        end
    end
end

// IFU
wire [31:0] pc   ;
wire [31:0] npc  ;
wire [31:0] instr;

// GRF
wire [31:0] dat1;
wire [31:0] dat2;

// ALU
wire        zero  ;
wire [31:0] aluRes;

// DM
wire [31:0] readData;

// control signal
wire       ext     ; // sign extend imm16 if 1
wire       aluSrc  ; // I-Type; load imm16 as srcB rather than GPR[rt]
wire       memWrite; // Store data from reg to mem
wire       regWrite; // for those "GPR[xx] <- xx" in RTL
wire [1:0] regDst  ; // R-Type; save value to GPR[rd] rather than GPR[rt]
wire [1:0] regFrom ; // Load data from mem to reg
wire [3:0] aluOp   ;
wire [2:0] npcOp   ;

// split instr to below
wire [ 4:0] rs    ;
wire [ 4:0] rt    ;
wire [ 4:0] rd    ;
wire [ 4:0] shamt ;
wire [ 5:0] funct ;
wire [ 5:0] opcode;
wire [15:0] imm16 ;
wire [25:0] target;

assign {opcode, rs, rt, rd, shamt, funct} = instr;
assign imm16  = instr[15:0];
assign target = instr[25:0];

/* EXT
sign-extend or zero-extend the imm16, according to the ext signal.  */
wire [31:0] extImm;
assign extImm = ext ? {{16{imm16[15]}}, imm16} : {16'b0, imm16};

/* NPC
process the branch signal. branch succeed only when aluRes == 0 */
wire [31:0] jAddr;
wire [31:0] bAddr;
assign jAddr = {pc[31:28], target, 2'b00};
assign bAddr = pc + 4 + (extImm << 2);
assign npc   = (npcOp == `NPC_DEFAULT ? pc + 4 :
    npcOp == `NPC_B ? (zero ? bAddr : pc + 4) :
    npcOp == `NPC_J ? jAddr :
    npcOp == `NPC_JR ? dat1:
    0);

/* GRF
process the A3's source. regDst == 1 -> R-type, save to GPR[rd]. link == 1 -> jal, save to GPR[31]. */
wire [ 4:0] a3   ;
wire [31:0] grfWD;
assign a3 = (regDst == `REGDST_DEFAULT ? rt :
    regDst == `REGDST_R ? rd :
    regDst == `REGDST_LINK ? 31 :
    0);
assign grfWD = (regFrom == `REGFROM_DEFAULT ? aluRes :
    regFrom == `REGFROM_LOAD ? readData :
    regFrom == `REGFROM_LINK ? pc + 4 :
    0);

/* ALU
process the source of srcB. aluSrc == 1 -> I-type, load from extImm. */
wire [31:0] srcB;
assign srcB = aluSrc ? extImm : dat2;

/* **NOTE**

DATAPATH ENDS HERE.

below are port definitions. */

pc _pc (
    .clk  (clk  ),
    .reset(reset),
    .npc  (npc  ),
    .pc   (pc   )
);

im _im (
    .pc   (pc   ),
    .instr(instr)
);

grf _grf (
    .clk      (clk     ),
    .reset    (reset   ),
    .regWrite (regWrite),
    .readAddr1(rs      ),
    .readAddr2(rt      ),
    .writeAddr(a3      ),
    .writeData(grfWD   ),
    .readData1(dat1    ),
    .readData2(dat2    )
);

alu _alu (
    .aluOp (aluOp ),
    .shamt (shamt ),
    .srcA  (dat1  ),
    .srcB  (srcB  ),
    .zero  (zero  ),
    .aluRes(aluRes)
);

dm _dm (
    .clk      (clk     ),
    .reset    (reset   ),
    .memWrite (memWrite),
    .memAddr  (aluRes  ),
    .writeData(dat2    ),
    .readData (readData)
);

ctrl _ctrl (
    .opcode  (opcode  ),
    .funct   (funct   ),
    .ext     (ext     ),
    .aluSrc  (aluSrc  ),
    .regDst  (regDst  ),
    .regFrom (regFrom ),
    .memWrite(memWrite),
    .regWrite(regWrite),
    .aluOp   (aluOp   ),
    .npcOp   (npcOp   )
);

endmodule
