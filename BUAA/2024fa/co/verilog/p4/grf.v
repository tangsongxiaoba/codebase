`default_nettype none

module grf (
    input  wire        clk,
    input  wire        reset,
    input  wire        regWrite,
    input  wire [ 4:0] readAddr1,
    input  wire [ 4:0] readAddr2,
    input  wire [ 4:0] writeAddr,
    input  wire [31:0] writeData,
    input  wire [31:0] pc,
    output wire [31:0] readData1,
    output wire [31:0] readData2
);

    reg [31:0] regFile[31:0];

    assign readData1 = regFile[readAddr1];
    assign readData2 = regFile[readAddr2];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            regFile[i] <= 0;
        end
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            for (i = 0; i < 32; i = i + 1) begin
                regFile[i] <= 32'b0;
            end
        end else if (regWrite == 1'b1) begin
            regFile[writeAddr] <= writeData;
            regFile[0]         <= 32'b0;
            $display("@%h: $%d <= %h", pc, writeAddr, writeData);
        end
    end

endmodule
