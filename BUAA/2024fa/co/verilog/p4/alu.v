`default_nettype none

module alu (
    input  wire [ 3:0] aluOp,
    input  wire [ 4:0] shamt,
    input  wire [31:0] srcA,
    input  wire [31:0] srcB,
    output wire        zero,
    output wire [31:0] aluRes
);

    parameter SLL = 0;
    parameter OR = 1;
    parameter ADD = 2;
    parameter LUI = 3;
    parameter SUB = 4;
    parameter XOR = 6;

    wire [31:0] sll_res, or_res, add_res, lui_res, sub_res, xor_res;

    assign sll_res = srcA << shamt;
    assign or_res  = srcA | srcB;
    assign add_res = srcA + srcB;
    assign lui_res = {srcB[15:0], 16'b0};
    assign sub_res = srcA - srcB;
    assign xor_res = srcA ^ srcB;

    assign aluRes  = (aluOp == SLL) ? sll_res :  // sll
 (aluOp == OR) ? or_res :  // or
 (aluOp == ADD) ? add_res :  // add
 (aluOp == LUI) ? lui_res :  // lui
 (aluOp == SUB) ? sub_res :  // sub
 (aluOp == XOR) ? xor_res : 0;  // xor

    assign zero = (aluRes == 0) ? 1 : 0;

endmodule
