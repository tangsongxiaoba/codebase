`default_nettype none

module npc (
    input  wire        pcSrc,         // b-Type sig
    input  wire        jump,          // j-Type sig
    input  wire [31:0] pc,
    input  wire [31:0] branchOffset,  // b-Type offset, from alu result.
    input  wire [31:0] jumpAddr,      // j-Type addr, from datapath (split from im's instr).
    output wire [31:0] npc
);

    assign npc = (jump) ? jumpAddr : ((pcSrc) ? (pc + 4 + (branchOffset << 2)) : (pc + 4));

endmodule
