`default_nettype none

module im (
    input  wire [31:0] pc,
    output wire [31:0] instr
);

    parameter IM_MAX = 4096;

    reg     [31:0] instrMem[0:IM_MAX-1];
    integer        i;

    initial begin
        for (i = 0; i < IM_MAX; i = i + 1) begin
            instrMem[i] = 0;
        end
        $readmemh("code.txt", instrMem, 0);
    end

    wire [31:0] addr;

    assign addr  = pc - 32'h0000_3000;

    assign instr = instrMem[addr[13:2]];

endmodule
