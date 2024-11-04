`default_nettype none

module mips (
    input wire clk,
    input wire reset
);

    // IFU
    wire [31:0] pc, npc;
    wire [31:0] instr;

    // GRF
    wire [31:0] dat1, dat2;

    // ALU
    wire        zero;
    wire [31:0] aluRes;

    // DM
    wire [31:0] readData;

    // control signal
    wire        jr;  // for jr, directly load GPR[rs] to PC
    wire        ext;  // sign extend imm16 if 1
    wire        jump;  // J-Type
    wire        link;  // for jal, choose PC4 as regWD and 31 as a3
    wire        aluSrc;  // I-Type; load imm16 as srcB rather than GPR[rt]
    wire        branch;  // B-Type
    wire        regDst;  // R-Type; save value to GPR[rd] rather than GPR[rt]
    wire        mem2Reg;  // Load data from mem to reg
    wire        memWrite;  // Store data from reg to mem
    wire        regWrite;  // for those "GPR[xx] <- xx" in RTL
    wire [ 3:0] aluOp;

    // split instr to below
    wire [ 4:0] rs;
    wire [ 4:0] rt;
    wire [ 4:0] rd;
    wire [ 4:0] shamt;
    wire [ 5:0] funct;
    wire [ 5:0] opcode;
    wire [15:0] imm16;
    wire [31:0] jaddr;

    assign {opcode, rs, rt, rd, shamt, funct} = instr;
    assign imm16                              = instr[15:0];

    /* EXT
    IM -> EXT -> NPC
            \
            --> ALU
    sign-extend or zero-extend the imm16, according to the ext signal.  */
    wire [31:0] extImm;
    assign extImm = ext ? {{16{imm16[15]}}, imm16} : {16'b0, imm16};

    /* NPC
    process the branch signal. branch succeed only when aluRes == 0 */
    wire pcSrc;
    assign pcSrc = zero & branch;
    assign jaddr = jr ? dat1 : {pc[31:28], instr[25:0], 2'b00};

    /* GRF
    process the A3's source. regDst == 1 -> R-type, save to GPR[rd]. link == 1 -> jal, save to GPR[31]. */
    wire [4:0] a3;
    assign a3 = link ? 5'b11111 : (regDst ? rd : rt);

    /* ALU
    process the source of srcB. aluSrc == 1 -> I-type, load from extImm. */
    wire [31:0] srcB;
    assign srcB = aluSrc ? extImm : dat2;

    /* DM
    ALU -> DM -> GRF

    process the output. mem2Reg == 1 -> load data from memory. */
    wire [31:0] dmRes;
    assign dmRes = link ? (pc + 4) : (mem2Reg ? readData : aluRes);

    /* **NOTE**
    
    DATAPATH ENDS HERE.

    below are port definitions. */

    pc _pc (
        .clk  (clk),
        .reset(reset),
        .npc  (npc),
        .pc   (pc)
    );

    im _im (
        .pc   (pc),
        .instr(instr)
    );

    npc _npc (
        .pcSrc       (pcSrc),
        .jump        (jump),
        .pc          (pc),
        .branchOffset(extImm),
        .jumpAddr    (jaddr),
        .npc         (npc)
    );

    grf _grf (
        .clk      (clk),
        .reset    (reset),
        .regWrite (regWrite),
        .readAddr1(rs),
        .readAddr2(rt),
        .writeAddr(a3),
        .writeData(dmRes),
        .pc       (pc),
        .readData1(dat1),
        .readData2(dat2)
    );

    alu _alu (
        .aluOp (aluOp),
        .shamt (shamt),
        .srcA  (dat1),
        .srcB  (srcB),
        .zero  (zero),
        .aluRes(aluRes)
    );

    dm _dm (
        .clk      (clk),
        .reset    (reset),
        .memWrite (memWrite),
        .pc       (pc),
        .memAddr  (aluRes),
        .writeData(dat2),
        .readData (readData)
    );

    ctrl _ctrl (
        .opcode  (opcode),
        .funct   (funct),
        .jr      (jr),
        .ext     (ext),
        .link    (link),
        .jump    (jump),
        .aluSrc  (aluSrc),
        .branch  (branch),
        .regDst  (regDst),
        .mem2Reg (mem2Reg),
        .memWrite(memWrite),
        .regWrite(regWrite),
        .aluOp   (aluOp)
    );

endmodule
