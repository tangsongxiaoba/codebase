`default_nettype none

module ctrl (
    input  wire [5:0] opcode,
    input  wire [5:0] funct,
    output wire       jr,        // for jr, directly load GPR[rs] to PC
    output wire       ext,       // sign extend imm16 if 1
    output wire       jump,      // J-Type
    output wire       link,      // for jal, choose PC4 as regWD and 31 as regAddr
    output wire       aluSrc,    // I-Type, load imm16 as srcB rather than GPR[rt]
    output wire       branch,    // B-Type
    output wire       regDst,    // R-Type, save value to GPR[rd] rather than GPR[rt]
    output wire       mem2Reg,   // Load data from mem to reg
    output wire       memWrite,  // Store data from reg to mem
    output wire       regWrite,  // for those "GPR[xx] <- xx" in RTL
    output wire [3:0] aluOp
);

    // opcode
    parameter R_TYPE = 6'b000000;
    parameter J = 6'b000010;
    parameter JAL = 6'b000011;
    parameter BEQ = 6'b000100;
    parameter ORI = 6'b001101;
    parameter LUI = 6'b001111;
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;

    //shamt
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter XOR = 6'b100110;
    parameter JR = 6'b001000;

    wire j, jal, beq, ori, lui, lw, sw, add, sub, x_or;

    // R-Type
    assign add      = (opcode == R_TYPE) & (funct == ADD);
    assign sub      = (opcode == R_TYPE) & (funct == SUB);
    assign x_or     = (opcode == R_TYPE) & (funct == XOR);
    assign jr       = (opcode == R_TYPE) & (funct == JR);

    //I-Type
    assign ori      = (opcode == ORI);
    assign lui      = (opcode == LUI);
    assign lw       = (opcode == LW);
    assign sw       = (opcode == SW);

    //B-Type
    assign beq      = (opcode == BEQ);

    //J-Type
    assign j        = (opcode == J);
    assign jal      = (opcode == JAL);

    //signals
    assign ext      = lw | sw | beq;
    assign jump     = j | jal | jr;
    assign link     = jal;
    assign aluSrc   = ori | lui | lw | sw;
    assign branch   = beq;
    assign regDst   = (opcode == R_TYPE);
    assign mem2Reg  = lw;
    assign memWrite = sw;
    assign regWrite = (opcode == R_TYPE) | lw | ori | lui | jal;

    //ALU Op
    assign aluOp[3] = 0;  // keep
    assign aluOp[2] = sub | x_or | beq;
    assign aluOp[1] = add | lw | sw | x_or | lui;
    assign aluOp[0] = ori | lui;

endmodule
