`include "macro.v"

module alu (
    input  wire [ 2:0] aluExcOp,
    input  wire [ 3:0] aluOp   ,
    input  wire [ 4:0] shamt   ,
    input  wire [31:0] srcA    ,
    input  wire [31:0] srcB    ,
    input  wire [31:0] pc      ,
    output wire        zero    ,
    output wire        exc_AdEL,
    output wire        exc_AdES,
    output wire        exc_Ov,
    output wire [31:0] aluRes
);

wire        sltRes = $signed(srcA) < $signed(srcB)      ;
wire [32:0] addRes = {srcA[31], srcA} + {srcB[31], srcB};
wire [32:0] subRes = {srcA[31], srcA} - {srcB[31], srcB};
wire        addOv  = (addRes[31] != addRes[32])         ;
wire        subOv  = (subRes[31] != subRes[32])         ;

assign exc_AdEL = (aluExcOp == `ALUE_ADEL) & (aluOp == `ALU_ADD) & addOv;
assign exc_AdES = (aluExcOp == `ALUE_ADES) & (aluOp == `ALU_ADD) & addOv;
assign exc_Ov   = (aluExcOp == `ALUE_OV) & (
    ((aluOp == `ALU_ADD) & addOv) |
    ((aluOp == `ALU_SUB) & subOv));

assign aluRes =
    (aluOp == `ALU_SLL) ? srcA << shamt :
    (aluOp == `ALU_OR) ? srcA | srcB :
    (aluOp == `ALU_ADD) ? addRes[31:0] :
    (aluOp == `ALU_LUI) ? {srcB[15:0], 16'b0} :
    (aluOp == `ALU_SUB) ? subRes[31:0] :
    (aluOp == `ALU_LINK) ? pc + 8 :
    (aluOp == `ALU_XOR) ? srcA ^ srcB :
    (aluOp == `ALU_AND) ? srcA & srcB :
    (aluOp == `ALU_SLT) ? sltRes :
    (aluOp == `ALU_SLTU) ? srcA < srcB :
    0;

assign zero = (aluRes == 0) ? 1 : 0;

endmodule
