`include "macro.v"

module split (
    input wire [31:0] instr,
    output wire [4:0] rs,
    output wire [4:0] rt,
    output wire [4:0] rd,
    output wire [4:0] shamt,
    output wire [5:0] funct,
    output wire [5:0] op,
    output wire [15:0] imm,
    output wire [25:0] j26
);

assign {op, rs, rt, rd, shamt, funct} = instr;
assign imm = instr[15:0];
assign j26 = instr[25:0];

endmodule
