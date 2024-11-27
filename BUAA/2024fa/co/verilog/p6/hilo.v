`include "macro.v"

module hilo (
    input  wire        clk   ,
    input  wire        reset ,
    input  wire [ 1:0] from  ,
    input  wire [ 3:0] start ,
    input  wire [31:0] srcA  ,
    input  wire [31:0] srcB  ,
    output wire        isbusy  ,
    output wire [31:0] result
);

assign {signed_mult_hi, signed_mult_lo} = $signed(srcA) * $signed(srcB);
assign {unsigned_mult_hi, unsigned_mult_lo} = srcA * srcB;

assign signed_div_hi   = $signed(srcA) % $signed(srcB);
assign signed_div_lo   = $signed(srcA) / $signed(srcB);
assign unsigned_div_hi = srcA % srcB;
assign unsigned_div_lo = srcA / srcB;

wire [63:0] calc_res =
    (start[0] == 1) ? (
        (start == `MULT) ? {signed_mult_hi, signed_mult_lo} :
        (start == `MULTU) ? {unsigned_mult_hi, unsigned_mult_lo} :
        (start == `DIV) ? {signed_div_hi, signed_div_lo} :
        (start == `DIVU) ? {unsigned_div_hi, unsigned_div_lo} :
        0) :
    0;

always @(posedge clk) begin
    if(reset) begin
        hi      <= 0;
        lo      <= 0;
        tmp_res <= 0;
        count   <= 0;
        _type   <= 0;
        busy    <= 0;
    end else begin
        if(start[0]) begin
            busy    <= 1;
            count   <= 0;
            tmp_res <= calc_res;
            _type   <= start[2];
        end
        else if(start == `MTHI || start == `MTLO) begin
            if(start == `MTHI) hi <= srcA;
            else lo <= srcA;
        end
        if(busy) begin
            count <= count + 1;
            if(count == (_type == 0 ? 5 : 10)) begin
                busy  <= 0;
                count <= 0;
                hi    <= tmp_res[63:32];
                lo    <= tmp_res[31: 0];
            end
        end
    end
end

assign result = (from == `REGFROM_HILO) ? (start == `MFHI ? hi : lo) : 0;

assign isbusy = busy;

reg [31:0] hi     ;
reg [31:0] lo     ;
reg [63:0] tmp_res;
reg [ 3:0] count  ;
reg        _type  ;
reg        busy   ;

wire [31:0] signed_mult_hi  ;
wire [31:0] signed_mult_lo  ;
wire [31:0] signed_div_hi   ;
wire [31:0] signed_div_lo   ;
wire [31:0] unsigned_mult_hi;
wire [31:0] unsigned_mult_lo;
wire [31:0] unsigned_div_hi ;
wire [31:0] unsigned_div_lo ;

endmodule
