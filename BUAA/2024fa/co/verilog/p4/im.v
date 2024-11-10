`include "macro.v"

module im (
    input  wire [31:0] pc   ,
    output wire [31:0] instr
);

reg     [31:0] instrMem[`IM_MAX-1:0];
integer        i                   ;

initial begin
    for (i = 0; i < `IM_MAX; i = i + 1) begin
        instrMem[i] = 0;
    end
    $readmemh(`CODEPATH, instrMem, 0);
end

wire [31:0] addr;

assign addr = pc - `PC_INIT;

assign instr = instrMem[addr[13:2]];

endmodule
