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

reg [31:0] alures;

always @(*) begin
    case (aluOp)
        `ALU_OR   : alures = srcA | srcB;
        `ALU_ADD  : alures = srcA + srcB;
        `ALU_LUI  : alures = {srcB[15:0], 16'b0};
        `ALU_SUB  : alures = srcA - srcB;
        `ALU_LINK : alures = pc + 8;
        `ALU_XOR  : alures = srcA ^ srcB;
        `ALU_AND  : alures = srcA & srcB;
        `ALU_SLT  : alures = $signed(srcA) < $signed(srcB);
        `ALU_SLTU : alures = srcA < srcB;
        default   : alures = srcA << shamt;
    endcase
end

assign aluRes = alures;
assign zero   = (alures == 0) ? 1 : 0;

endmodule
