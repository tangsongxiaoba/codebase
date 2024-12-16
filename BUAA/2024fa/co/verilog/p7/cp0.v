`include "macro.v"

module cp0 (
    input  wire        clk,
    input  wire        reset,
    input  wire        en,
    input  wire        BDIn,
    input  wire        EXLClr,
    input  wire [ 4:0] CP0Add,
    input  wire [ 4:0] ExcCodeIn,
    input  wire [ 5:0] HWInt,
    input  wire [31:0] CP0In,
    input  wire [31:0] vpc,
    output wire        Req,
    output wire [31:0] CP0Out,
    output wire [31:0] EPCOut
);

reg [31:0] SR   ;
reg [31:0] Cause;
reg [31:0] EPC  ;

wire exception = !`EXL && (|ExcCodeIn)            ;
wire interrupt = !`EXL && `IE && (| (HWInt & `IM));

assign Req = exception | interrupt;

initial begin
    SR <= 0;
    Cause <= 0;
    EPC <= 0;
end

assign EPCOut = (
    Req ? (BDIn ? (vpc - 4) : vpc) :
    EPC
);

assign CP0Out = (
    (CP0Add == 12) ? SR :
    (CP0Add == 13) ? Cause :
    (CP0Add == 14) ? EPCOut :
    0
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        SR    <= 0;
        Cause <= 0;
        EPC   <= 0;
    end else begin
        `IP <= HWInt;
        if (EXLClr) begin
            `EXL <= 0;
        end
        if (Req) begin
            `EXCCODE <= interrupt ? 0 : ExcCodeIn;
            `EXL     <= 1;
            EPC      <= EPCOut;
            `BD      <= BDIn;
        end else if (en) begin
            if (CP0Add == 12) SR <= CP0In;
            else if (CP0Add == 14) EPC <= CP0In;
        end
    end
end

endmodule
