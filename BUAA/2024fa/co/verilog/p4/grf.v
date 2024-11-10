`include "macro.v"

module grf (
    input  wire        clk      ,
    input  wire        reset    ,
    input  wire        regWrite ,
    input  wire [ 4:0] readAddr1,
    input  wire [ 4:0] readAddr2,
    input  wire [ 4:0] writeAddr,
    input  wire [31:0] writeData,
    output wire [31:0] readData1,
    output wire [31:0] readData2
);

reg [31:0] regFile[`REG_MAX-1:0];

assign readData1 = regFile[readAddr1];
assign readData2 = regFile[readAddr2];

integer i;

initial begin
    for (i = 0; i < `REG_MAX; i = i + 1) begin
        regFile[i] = 0;
    end
end

always @(posedge clk) begin
    if (reset == 1'b1) begin
        for (i = 0; i < `REG_MAX; i = i + 1) begin
            regFile[i] <= 32'b0;
        end
    end else if (regWrite == 1'b1) begin
        regFile[writeAddr] <= writeData;
        regFile[0]         <= 32'b0;
    end
end

endmodule
