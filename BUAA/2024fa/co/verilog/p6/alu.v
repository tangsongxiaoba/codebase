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

wire [31:0] sll_res ;
wire [31:0] or_res  ;
wire [31:0] add_res ;
wire [31:0] lui_res ;
wire [31:0] sub_res ;
wire [31:0] xor_res ;
wire [31:0] and_res ;
wire [31:0] slt_res ;
wire [31:0] sltu_res;

assign sll_res = srcA << shamt;
assign or_res  = srcA | srcB;
assign add_res = srcA + srcB;
assign lui_res = {srcB[15:0], 16'b0};
assign sub_res = srcA - srcB;
assign xor_res = srcA ^ srcB;
assign and_res = srcA & srcB;
wire slt_cmp  = $signed(srcA) < $signed(srcB);
wire sltu_cmp = srcA < srcB                  ;
assign slt_res  = slt_cmp;
assign sltu_res = sltu_cmp;

assign aluRes = (aluOp == `ALU_SLL) ? sll_res :  // sll
    (aluOp == `ALU_OR) ? or_res :                // or
    (aluOp == `ALU_ADD) ? add_res :              // add
    (aluOp == `ALU_LUI) ? lui_res :              // lui
    (aluOp == `ALU_SUB) ? sub_res :              // sub
    (aluOp == `ALU_LINK) ? pc + 8 :              // link (jal)
    (aluOp == `ALU_XOR) ? xor_res :              // xor
    (aluOp == `ALU_AND) ? and_res :              // and
    (aluOp == `ALU_SLT) ? slt_res :              // slt
    (aluOp == `ALU_SLTU) ? sltu_res :              // sltu
    0;

assign zero = (aluRes == 0) ? 1 : 0;

endmodule
