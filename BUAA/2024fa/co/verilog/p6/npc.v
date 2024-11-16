`include "macro.v"

module npc (
    input wire [31:0] pc,
    input wire [25:0] j26,
    input wire [15:0] imm,
    input wire [31:0] rO1,
    input wire zero,
    input wire [2:0] npcOp,
    output wire [31:0] npc
);

wire [31:0] jaddr;
wire [31:0] baddr;

assign jaddr = {pc[31:28], j26, 2'b00};
assign baddr = pc + 4 + {{14{imm[15]}}, imm, 2'b00};
assign npc   = (npcOp == `NPC_DEFAULT ? 0 : // actually pc_F + 4
    (npcOp == `NPC_B ? (zero ? baddr : 0) :
        (npcOp == `NPC_J ? jaddr :
            (npcOp == `NPC_JR ? rO1 :
                0))));
endmodule
