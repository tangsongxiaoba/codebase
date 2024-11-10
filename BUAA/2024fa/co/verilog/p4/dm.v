`include "macro.v"

module dm (
    input  wire        clk      ,
    input  wire        reset    ,
    input  wire        memWrite ,
    input  wire [31:0] memAddr  ,
    input  wire [31:0] writeData,
    output wire [31:0] readData
);

reg     [31:0] dataMem[`DM_MAX-1:0];
integer        i                  ;

initial begin
    for (i = 0; i < `DM_MAX; i = i + 1) begin
        dataMem[i] = 0;
    end
end

assign readData = dataMem[memAddr[13:2]];

always @(posedge clk) begin
    if (reset == 1'b1) begin
        for (i = 0; i < `DM_MAX; i = i + 1) begin
            dataMem[i] <= 32'b0;
        end
    end else if (memWrite == 1'b1) begin
        dataMem[memAddr[13:2]] <= writeData;
    end
end


endmodule
