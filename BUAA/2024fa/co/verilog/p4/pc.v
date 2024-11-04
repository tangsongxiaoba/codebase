`default_nettype none

module pc (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] npc,
    output wire [31:0] pc
);

    parameter PC_INIT = 32'h0000_3000;

    reg [31:0] addr;

    initial begin
        addr <= PC_INIT;
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            addr <= PC_INIT;
        end else begin
            addr <= npc;
        end
    end

    assign pc = addr;

endmodule
