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

wire [31:0] sll_res;
wire [31:0] or_res ;
wire [31:0] add_res;
wire [31:0] lui_res;
wire [31:0] sub_res;
wire [31:0] xor_res;

assign sll_res = srcA << shamt;
assign or_res  = srcA | srcB;
assign add_res = srcA + srcB;
assign lui_res = {srcB[15:0], 16'b0};
assign sub_res = srcA - srcB;
assign xor_res = srcA ^ srcB;

assign aluRes = (aluOp == `ALU_SLL) ? sll_res :  // sll
    (aluOp == `ALU_OR) ? or_res :                // or
    (aluOp == `ALU_ADD) ? add_res :              // add
    (aluOp == `ALU_LUI) ? lui_res :              // lui
    (aluOp == `ALU_SUB) ? sub_res :              // sub
    (aluOp == `ALU_LINK) ? pc + 8 :              // link (jal)
    (aluOp == `ALU_XOR) ? xor_res :              // xor
    0;

assign zero = (aluRes == 0) ? 1 : 0;

endmodule
