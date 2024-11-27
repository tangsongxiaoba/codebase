`include "macro.v"

module alu (
    input  wire [ 3:0] aluOp ,
    input  wire [ 4:0] shamt ,
    input  wire [31:0] srcA  ,
    input  wire [31:0] srcB  ,
    input  wire [31:0] pc    ,
    output wire        zero  ,
    output wire [31:0] aluRes
);

wire sltRes = $signed(srcA) < $signed(srcB);

assign aluRes =
    (aluOp == `ALU_SLL) ? srcA << shamt :
    (aluOp == `ALU_OR) ? srcA | srcB :
    (aluOp == `ALU_ADD) ? srcA + srcB :
    (aluOp == `ALU_LUI) ? {srcB[15:0], 16'b0} :
    (aluOp == `ALU_SUB) ? srcA - srcB :
    (aluOp == `ALU_LINK) ? pc + 8 :
    (aluOp == `ALU_XOR) ? srcA ^ srcB :
    (aluOp == `ALU_AND) ? srcA & srcB :
    (aluOp == `ALU_SLT) ? sltRes :
    (aluOp == `ALU_SLTU) ? srcA < srcB :
    0;

assign zero = (aluRes == 0) ? 1 : 0;

endmodule
